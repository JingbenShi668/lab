# concluding report

## Project information


- <b>Project name</b>：Automatic Chinese translation of Chaoss metrics<br/>

- <b> Program description</b>：</br>
Build a GitHub app based on the GitHub open source project Hypertrons, and integrate this GitHub app into the relevant warehouse corresponding to "Chaoss Metrics Translation",
In this way, the related functions required by "Chaoss Metrics Translation" can be realized.

- <b>Time plan</b>: </br>
   - 7/1-7/31： Understanding the related design and applicable scenarios of Hypertrons.<br/>
     
   - 8/1-8/20： Understanding and learning TypeScript and Lua syntax, and preparing for writing script later.<br/>
     
   - 8/21-8/31：Running the Hypertrons instance locally, publishing it on the GitHub marketplace, and connecting it to the GitHub repository corresponding to the project.<br/>
     
   - 9/1-9/20： Writing scripts using Ts and Lua under the corresponding warehouse of the project, call Hypertrons related services, and realize project requirements.<br/>
     
   - 9/20-9/30：Communicating with the instructor to further improve the automation process.


## Project summary


- <b>Project output</b>：
  
    In this summer practice, the open source translation component based on the open source project [Hypertrons](https://www.hypertrons.io/#) is TransForChaossApps123.
    The GitHub access address of this translation component is [github.com/apps/transforchaossapps123](https://github.com/apps/transforchaossapps123).<br/>
  
   <b>1. Monitoring issue changes and obtaining issue information</b><br/>
   The Chaoss official community raised an issue in the warehouse corresponding to "Chaoss Metrics Translation". The issue contained relevant English Metrics proposed by Chaoss.
   At this time, the Github app, transforchaossapps123, can monitor the changes in the issue, and obtain information about the issue, such as issue title,
   Issue body and other information, so we get the chaoss metrics data waiting to be translated.<br/>

    <b>2. Translating Chaoss indicator information</b><br/>
   This goal is mainly achieved through the translation interface of Hypertrons, among which the open source project Hypertrons integrates the Google translation interface and Hypertrons can achieve a variety of
   Translation conversion between languages. This project mainly realized the need to translate the English Chaoss indicator into Chinese.
   Among them, regarding the triggering of the translation function in transforchaossapps123, you can use '/translate' in the issues related to the chaoss metrics
   Comment, you can automatically call the translation component in transforchaossapps123.<br/>

    <b>3. Temporarily saving the index translation results, and submitting PR from the dev branch to the main branch</b><br/>
   In step two, the metrics translation has been implemented. In this step, the translated results can be saved in a file of a development branch B. Then transforchaossapps123
   Will automatically propose PR from the B branch to the main branch.<br/>

    <b>4. GitHub connecting to Slack</b><br/>
   By adding the Slack webhook link to the GitHub repository corresponding to Chaoss metrics translation, you can set the slack channel to accept
   GitHub warehouse related notifications. Also, notification content of the GitHub warehouse can be customized, and the GitHub warehouse can be designated to send the specified Issue and PR to slack.<br/>

- <b>Plan progress</b>：
  
    The content in the time plan has been basically realized in accordance with the original plan, such as basic monitoring of issues, translating metrics, saving translation results. In addtion the Github APP can  submit PR from the development branch to
    the main branch and send warehouse update information to the slack channel.

    It is currently in the optimization stage of the automation process. After the end of this project, there are still some parts that can be optimized. For example, automatically read the information contained in the issue, 
    and the content corresponding to the link, etc.. But it can only read the text information in the issue body at present.

- <b>Problems encountered and solutions</b>：
  
    During the process of implementing automated translation plugin transforchaossapps123 based on the open source project Hypertrons
, the main problem encountered is the using of the open source project Hypertrons, which requires a deep understanding of Hypertrons’s architecture design and the encapsulation of functions and interfaces. 
Otherwise, it is difficult to implement your own translation plugin.

    The technology used in this project are basically TypeScript and Lua. TS is also widely used in various open source plug-in projects, but the Promise object in TS is difficult to use.
And you must handle the callback functions that Promise may correspond to, otherwise you will encounter many problems when calling various interfaces in Hypertrons. In addition, I need to pay attention to the various
combination of off-the-shelf components, this can simplify the work and use the native components provided by Hypertrons to implement related functions.


- <b>Project completion quality</b>：

   For this "CHAOSS Metrics Automated Translation" project, the core functions have basically been realized, which can realize automatic translation, automatic submission of changes to the translation warehouse, automatic notification of slack and other functions.
   It can be said that the workload is quite full.<br/>
  
   However, there are still some problems in the implementation of the project. For example, it may be necessary to directly include metrics information in the issue, so that the automatic translation plugin transforchaossapps123 can be executed.
   For processes such as automatic translation, if the issue only contains a link related to the indicator, then you need to manually submit an issue that contains indicator information. After that, the plugin try to access and read corresponding content in the link
   , I will achieve a more complete automated translation process later.
  
   In addition, the accuracy of project translation needs to be further improved. It is necessary to organize the metrics system and apply the metrics system to the translation process to achieve more accurate translation. 
   The model of "translation after word segmentation" may be used later, and this translation process needs to be practiced.<br/>

- <b>Feedback  after communicating with mentors</b>：

    The metrics translation automation has been basically realized, but there are still some problems. And if possible, the student need to continue to improve. The lack of implementation of some non-core functions, if implemented, the translation plugin function will be very
    perfected, so that it can truly realize "metrics translation automation".