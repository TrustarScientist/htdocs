<?php
    require_once "core2.php";
    require_once "engine/base-models/models2.php";
    class Request{
        public $uri = "";
        public $subroute = "";
        public $method = "GET";
        public $is_authenticated = false;
        public $POST = array();
        public $GET  = array();
        public $FILES = array();
        public $userid = "";
        function __construct(){
            if(isset($_SERVER["REQUEST_URI"])){
                $this->uri = $_SERVER["REQUEST_URI"];
            }
            if(isset($_SERVER["REQUEST_METHOD"])){
                $this->method = $_SERVER["REQUEST_METHOD"];
            }
            $this->is_authenticated = Auth2::check();
            $this->POST = $_POST;
            $this->GET = $_GET;
            $this->FILES = $_FILES;
            if(isset($_SESSION["user"])){
                $this->userid = $_SESSION["user"];
            }
        }
    }
    function render($request, $template, $dataset=""){
        $path = "templates/".$template;
        if(file_exists($path)){
            require_once $path;
        }
        else{
            header("Location:/404");
        }
    }
?>