<?php
    require_once "engine/base-controllers/core.php";
    require_once "engine/settings.php";

    // create the Request object...that other codes need 
    $request = new Request();
    
    /**
     *  use the default controller if the uri does not have trailing slash 
     *  The trailing slash makes the router to decide the appropriate 'app' in the project
     *  Every 'app' or controller has a starting uri they listen to, sub-router and view functions 
     *  at minimum...models are optional for database works
     */
    
    // check whether the uri is root slash or with some text after slash..but no another slash after text
    // so that we can redirect to the default 'app' instead of scanning through the other apps
    if((preg_match("/^\/([@\w]*)$/", $request->uri, $matches))){
        
        $defaultData = $matches[1];
        
        // get the default app url patterns...and view functions
        if(file_exists("apps/default/urls.php")){
            require_once "apps/default/urls.php";
            if(isset($urlpatterns)){
                // default function to run in case not match
                $handler = function(){
                    // show 404 error page by default
                    header("Location:/404");
                };
                // scan through default urls and call appropriate view functions
                foreach ($urlpatterns as $defaultSubPath => $viewFunc) {
                    # code...
                    if(!empty(preg_match($defaultSubPath, $defaultData))){
                        $handler = $viewFunc;
                        break;
                    }
                }
                // run the handler function
                $handler($request, $defaultData);
            }
        }
    }
    else{
        /**
         *  We need to split the request uri to strings representing the 
         *  controller starting uri and pass some sub-routes it might need to work on.
         *  
         */
        $appPath = "";
        preg_match("/^\/(\w+)\/([@\w\/-]*)$/",$request->uri, $matches);
        $appPath = $matches[1];
        $subRoute = $matches[2];
        $app2use = "";
        // scan through installed apps and pick the app to use from settings file
        foreach ($installedApps as $appName => $path) {
                if($path == $appPath){
                    $app2use =  $appName;
                }
        }
        
        /**
         *  in case no app is found, display 404 page
         */

        if($app2use == ""){
            header("Location:/404");
        }
        else{
            // default handler in 'app'
            $appLevelHandler = function(){
                header("Location:/404");
                
            };
            /**
             *  require the urls.php if exists...no fall back mechanism here...ok?
             */
            if(file_exists("apps/".$app2use."/urls.php")){
                // we expect a urlpatterns array in urls.php
                require_once "apps/".$app2use."/urls.php";
                foreach ($urlpatterns as $pattern => $handler) {
                    # code...
                    if(!empty(preg_match($pattern, $subRoute,$subMatch))){
                        $appLevelHandler = $handler;
                        break;
                    }
                
                }
                // call the view function to handle request
                $appLevelHandler($request, $subMatch);

            }
        

        }
      

    }

?>