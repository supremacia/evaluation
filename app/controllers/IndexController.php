<?php

use Phalcon\Mvc\Controller;
use App\Models;

class IndexController extends Controller
{

	/**
	 * Link (relativo ao root) para os arquivos de media (imagens, no caso)
	 * @var string
	 */
	private $mediaUrl = '/media';


	/**
	 * Listagem dos últimos imóveis inseridos
	 * @return html envia a página ao cliente
	 */
	public function indexAction()
	{
		$imoveis = Imovel::find([ "ativo != 'N'",
								  'order' => 'id DESC',
								  'limit' => 6,]);

		$this->view->setVar('imoveis', $imoveis);
		$this->view->setVar('menuInicioActive', 'active');		
        $this->view->setVar('mediaUrl', $this->mediaUrl);
	}

}
