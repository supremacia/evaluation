<?php

use Phalcon\Mvc\Controller;
use App\Models;

class IndexController extends Controller
{

	public function indexAction()
	{
		$imoveis = Imovel::find([ "ativo != 'N'",
								  'order' => 'id DESC',
								  'limit' => 10,]);

		$this->view->setVar('imoveis', $imoveis);
	}

}
