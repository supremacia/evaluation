<?php 

// ------------------------------------------------ hacked BEGIN
// REMOVE this in Apache (and others) | this is to run on PHP buit-server, only.
//$_GET['_url'] = $_SERVER['REQUEST_URI'];
// ------------------------------------------------ hacked END



use Phalcon\Db\Adapter\Pdo\Mysql as DbAdapter;
use Phalcon\Di\FactoryDefault;
use Phalcon\Loader;
use Phalcon\Mvc\Application;
use Phalcon\Mvc\Url as UrlProvider;
use Phalcon\Mvc\View;
use Phalcon\Mvc\View\Engine\Volt;

define('BASE_PATH', dirname(__DIR__));
define('APP_PATH', BASE_PATH . '/app');

// Register an autoloader
$loader = new Loader();
$loader->registerDirs(
    array(
        APP_PATH . '/controllers/',
        APP_PATH . '/models/'
    )
)->register();

// Create a DI
$di = new FactoryDefault();

$di->setShared('session', function () {
    $session = new SessionAdapter();
    $session->start();

    return $session;
});

$di->set('cookies', function() {
    $cookies = new Phalcon\Http\Response\Cookies();
    $cookies->useEncryption(false);
    return $cookies;
});

$di->set('flash', function() {
    $flash = new \Phalcon\Flash\Session([
        'error'     => 'alert alert-danger',
        'success'   => 'alert alert-success',
        'notice'    => 'alert alert-info',
        'warning'   => 'alert alert-warning'
    ]);
    return $flash;
});

/* View */
$di->set("voltService", function ($view, $di) {
        $volt = new Volt($view, $di);
        $volt->setOptions(["compiledPath"  => "../app/compiled-templates/","compiledExtension" => ".compiled", 'compileAlways' => true]);
        return $volt;
    }
);

// Setting up the view component
$di->set('view', function() {
    $view = new View();
    $view->setViewsDir(APP_PATH . '/views/');
    $view->setLayoutsDir(APP_PATH . '/views/layouts/');
    $view->registerEngines([".volt" => "voltService"]);
    
    return $view;
});

// Setup a base URI so that all generated URIs include the "tutorial" folder
$di->set('url', function() {
    $url = new UrlProvider();
    $url->setBaseUri('/');
    return $url;
});

$di->set('router', require realpath(APP_PATH . '/config/routes.php'));

// Set the database service
$di->set('db', function() {
    return new DbAdapter(array(
        "host"     => "127.0.0.1",
        "username" => "avaliacao1",
        "password" => "yDjj4Xdop_#regh",
        "dbname"   => "avaliacao1"
    ));
});

// Handle the request
try {
    $application = new Application($di);
    echo $application->handle()->getContent();
} catch (Exception $e) {
     echo "Exception: ", $e->getMessage();
}
