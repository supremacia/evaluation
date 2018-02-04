<?php
use Phalcon\Mvc\Router;
$router = new Router(false);
$router->removeExtraSlashes(true);
$router->notFound(['controller' => 'Error', 'action' => 'error404']);

$router->add('/',                  ['controller' => 'Index', 'action' => 'index'])->setName('site.inicio');
$router->add('/imoveis',           ['controller' => 'Imovel', 'action' => 'listar'])->setName('site.imovel.listar');
$router->add('/imoveis/adicionar', ['controller' => 'Imovel', 'action' => 'adicionar'])->setName('site.imovel.adicionar');

$router->add('/imoveis/editar/{id}', ['controller' => 'Imovel', 'action' => 'editar'])->setName('site.imovel.editar');
$router->add('/imoveis/visulizar/{id}', ['controller' => 'Imovel', 'action' => 'visualizar'])->setName('site.imovel.visualizar');

$router->add('/imoveis/remover/{id}', ['controller' => 'Imovel', 'action' => 'remover'])->setName('site.imovel.remover');


// Ajax  routes
$router->add('/upload/image', ['controller' => 'Ajax', 'action' => 'uploadImage'])->setName('site.ajax.image');
$router->add('/upload/adicionar', ['controller' => 'Ajax', 'action' => 'adicionar'])->setName('site.ajax.adicionar');

//validators (ping)
$router->add('/upload/validar/codigo', ['controller' => 'Ajax', 'action' => 'validateCodigo'])->setName('site.ajax.validar.codigo');


return $router;