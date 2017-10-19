
def DeployDacpac() {
    def SqlPackage   = "C:\\Microsoft.Data.Tools.Msbuild.10.0.61026\\lib\\net40\\sqlpackage.exe"
    def SourceFile   = "SsdtDevOpsDemo\\bin\\Release\\SsdtDevOpsDemo.dacpac"
    def ConnString = "server=db,1433;database=SsdtDevOpsDemo;user id=sa;password=P@ssW0rd!"
    unstash 'theDacpac'
    
    bat "\"${SqlPackage}\" /Action:Publish /SourceFile:\"${SourceFile}\" /TargetConnectionString:\"${ConnString}\" /p:ExcludeObjectType=Logins"
}

node  {
    stage('git checkout') {
        git 'https://github.com/chrisadkin/SelfBuildPipeline' 
    }
    stage('build dacpac') {
        bat "\"${tool name: 'Default', type: 'msbuild'}\" /p:Configuration=Release /p:SQLDBExtensionsRefPath=\"C:\\Microsoft.Data.Tools.Msbuild.10.0.61026\\lib\\net40\" /p:SqlServerRedistPath=\"C:\\Microsoft.Data.Tools.Msbuild.10.0.61026\\lib\\net40\""
        stash includes: 'SsdtDevOpsDemo\\bin\\Release\\SsdtDevOpsDemo.dacpac', name: 'theDacpac'
    }
    stage('deploy dacpac') {
        try {
            DeployDacpac()
        }
        catch (error) {
            throw error
        }
    }
}