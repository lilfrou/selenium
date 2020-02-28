
pipeline {
    agent any
    tools {
        maven 'maven3.6.1'
        jdk 'jdk'
        nodejs 'node' 
    }

     stages { 
         stage('Cron'){

             steps{
                 sh"chmod +x wipe.sh"
                 sh "./wipe.sh"
             }
         }
     }
}
            
