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

--[[sched(compConfig.schedName, compConfig.sched, function ()
  wrap(function ()]]

local issue_Body = '';

on('IssueEvent', function (e)
  if (e.action == 'opened') then
    local commentTitle = renderString(config['issue-english-translator'].title, {title=translatedTitle});
    issue_Body = renderString(config['issue-english-translator'].body, {body=translatedBody});
    log('issue_Body-------------'..issue_Body);
  end
end)


on('CommandEvent', function (e)
  log('Enter...........................................')
  if (e.command == compConfig.command) then

    -- Save the English Metrics in related Issue to enMetrics file
    createOrUpdateFile(compConfig.enMetricsFile,issue_Body,'add English Metrics data','auto');

    -- Translate English Metrics into Chinese
    local enMetricsToChinese = translateMetrics(issue_Body,'zh')
    --[[    if(enMetricsRaw ~= nil) then
          log('enMetricsToChinese Content-----------------------------------')
          log('enMetricsToChinese Content: '..enMetricsToChinese)
        end]]

    -- 翻译结果完成后，将文件保存在auto分支上的txt文件中, getFileContent+createOrUpdateFile命令的组合使用
    local enMetricsRaw = getFileContent(compConfig.resultMetricsFile).content
    log('enMetricsRaw: '..enMetricsRaw);
    --[[    enMetricsNew = enMetricsRaw..'希望明天是个晴天～';]]
    enMetricsNew = enMetricsRaw..enMetricsToChinese;
    createOrUpdateFile(compConfig.resultMetricsFile,enMetricsNew,'save translation data','auto');

    --翻译结果保存到文件中后，提交PR
    newPullRequest(compConfig.title,compConfig.body,compConfig.head,compConfig.base,compConfig.allowModify);

  end
end)
