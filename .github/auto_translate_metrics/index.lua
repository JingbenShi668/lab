-- Copyright 2019 - present Xlab
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

-- Auto update report scheduler

sched(compConfig.schedName, compConfig.sched, function ()
  wrap(function ()
    log('Gonna get the content of the Chaoss English Metrics')
    -- Read Chaoss Metrics Dir
    local metricsDir = getDirectoryContent(compConfig.metricsDir)
    if (metricsDir == nil) then
      log('No metrics file found under'..compConfig.metricsDir)
      return
    end
    log('Find '..#metricsDir..' Metrics Dir')

    -- Read Chaoss English Metrics File
    local enMetricsRaw = getFileContent(compConfig.enMetricsFile).content
    if(enMetricsRaw ~= nil) then
      log('enMetricsRaw Content-----------------------------------')
      log('enMetricsRaw Content: '..enMetricsRaw)
    end


    -- Read all sqls from remote repo
    local sqlDir = getDirectoryContent(compConfig.sqlsDir)
    if (sqlDir == nil) then
      log('No sql found under'..compConfig.sqlsDir)
      return
    end
    log('Find '..#sqlDir..' SQLs dir')

    -- Read sql details and request result
    local sqlRenderParams = {}
    for i=1, #sqlDir do
      local sqlMeta = sqlDir[i]
      if (sqlMeta.type == 'dir') then
        local sqlRaw = getFileContent(sqlMeta.path..compConfig.sqlFile).content
        local manifest = string2table(getFileContent(sqlMeta.path..compConfig.sqlManifestFile).content)
        local postProcessor = getFileContent(sqlMeta.path..compConfig.sqlPostProcessorFile).content
        local preProcessorFile = getFileContent(sqlMeta.path..compConfig.sqlPreProcessorFile)
        local preProcessorResult = {}
        if (preProcessorFile ~= nil) then
          preProcessorResult = runJsCode(preProcessorFile.content, manifest.config)
        end

        -- render sql
        local sql = rendStr(sqlRaw, manifest.config, compConfig.defaultRenderParams, preProcessorResult)
        -- request run sql
        local requestRes = requestUrl({
          ['url'] = compConfig.sqlRequestUrl,
          ['method'] = 'POST',
          ['form'] = {
            ['query'] = sql
          }
        })
        local renderText = runJsCode(postProcessor, string2table(requestRes).data, compConfig.defaultRenderParams, manifest.config)
        log('Sql run result for '..sqlMeta.name..' is '..requestRes)
        sqlRenderParams[sqlMeta.name] = {
          ['sql'] = sqlRaw,
          ['text'] = renderText,
          ['config'] = manifest.config
        }
      end
    end

    -- render report
    local originReport = getFileContent(compConfig.reportFile)
    local reportTemplate = getFileContent(compConfig.reportTemplateFile)

    local newReport = rendStr(reportTemplate.content, compConfig.defaultRenderParams, {
      ['sqls'] = sqlRenderParams
    })
    log('Rendered report is '..newReport)

    -- update report by pull
    if (newReport ~= originReport.content) then
      log('Gonna update report by pull')
      local branchName = rendStr(compConfig.newBranchName, {
        ['timestamp'] = getNowTime()
      })
      newBranch(branchName, compConfig.defaultBranch)
      createOrUpdateFile(compConfig.reportFile, newReport, rendStr(compConfig.commitMessage, { ['branchName'] = branchName }), branchName)
      createOrUpdateFile(compConfig.reportWebFile, newReport, rendStr(compConfig.commitMessage, { ['branchName'] = branchName }), branchName)
      newPullRequest({
        ['title'] = rendStr(compConfig.pullTitle, { ['branchName'] = branchName }),
        ['body'] = rendStr(compConfig.pullBody, { ['branchName'] = branchName }),
        ['head'] = branchName,
        ['base'] = compConfig.defaultBranch,
        ['allowModify'] = true,
      })
    end
  end)
end)
