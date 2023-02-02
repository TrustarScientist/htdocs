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
    // so that we can redirect to the default 'app' instead of scanning through the other apps (\?[@*\w.+&^$?=%-]*)?
    //regex to get controller code :: "/^\/(\w+)\/([@*\w.+&^$=%-]*)(\?[@*\w.+&^$?=%-]*)?$/"


    if((preg_match("/^\/(\w*)(\?[_@*\w.+&^$?=%-]*)?$/", $request->uri, $matches))){
        
        $defaultUrl = $matches[1];
        
        
        if(file_exists("apps/default/urls.php")){
            require_once "apps/default/urls.php";
            if(isset($urlpatterns)){
                // default function to run in case not match
                $handler = function(){
                    // show 404 error page by default
                    header("Location:/404#invalid-url");
                };
                // scan through default urls and call corresponding view functions
                foreach ($urlpatterns as $urlPattern => $viewFunc) {
                    # code...
                    if(!empty(preg_match($urlPattern, $defaultUrl))){
                        $handler = $viewFunc;
                        break;
                    }
                    
                }
                // run the handler function
                $handler($request, $defaultUrl);
            }
        }
    }
    else if((preg_match("/^\/(\w+)\/([_@*\w.+&\/^$=%-]*)(\?[@*\w.+&^$?=%-]*)?$/", $request->uri, $matches2))){
        $appUrl = $matches2[1];
        $appSubUrl = $matches2[2];
        $app2use = null;
        // scan through installed apps and pick the app to use from settings file
        foreach ($installedApps as $installedApp => $registeredAppPath) {
            if($appUrl == $registeredAppPath){
                $app2use =  $installedApp;
            }
        }
        // now parse the app's urlpatterns  and run corresponding view functions...if the app is ever found.
        if($app2use == ""){
            header("Location:/404#na2u");
        }
        else{
            // default handler in 'app'
            $appLevelHandler = function(){
                header("Location:/404#nhf");
                
            };
            // scan app  
            if(file_exists("apps/".$app2use."/urls.php")){
                // we expect a urlpatterns associative array in urls.php
                require_once "apps/".$app2use."/urls.php";
                foreach ($urlpatterns as $appUrlPattern => $appViewFunction) {
                    # code...
                    if(!empty(preg_match($appUrlPattern, $appSubUrl,$appMatch))){
                        $appLevelHandler = $appViewFunction;
                        break;
                    }
                
                }
                // call the view function to handle request
                $appLevelHandler($request, $appMatch);

            }
        

        }

    }
    else{
        echo "Lastly, this URL does not fit in...sorry!";
        
    }
    /**
         *  We need to split the request uri to strings representing the 
         *  controller starting uri and pass some sub-routes it might need to work on.
         *  
         
    else if(preg_match('/([#$^&*()+=\-\[\]\';,.\/{}|":<>?~\\\\]+)/',preg_quote($request->uri), $matches2)){

        echo "woo0000oooow";
        print_r($matches2);
        print_r($request->uri);

        
        $appPath = "";
        preg_match("/^\/([\w]+)\/([@*\w.+&^$?=%-]*)(\?[@*\w.+&^$?=%-]*)?$/",preg_quote($request->uri), $matches);
        $appPath = $matches[1];
        $subRoute = $matches[2];
        $app2use = "";
        // scan through installed apps and pick the app to use from settings file
        foreach ($installedApps as $appName => $path) {
                if($path == $appPath){
                    $app2use =  $appName;
                }
        }
        
        
        if($app2use == ""){
            header("Location:/404#$ssd");
        }
        else{
            // default handler in 'app'
            $appLevelHandler = function(){
                header("Location:/404#handlernotfound");
                
            };
            
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
    else{
        echo "finally...no hpoe";
    }
    */
?>