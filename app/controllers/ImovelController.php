<?php 

use Phalcon\Mvc\Controller;

class ImovelController extends Controller
{

	public function listarAction()
	{
        $imoveis = Imovel::find("ativo != 'N'");
        $this->view->setVar('imoveis', $imoveis); 
        $this->view->setVar('tipoimovel', TipoImovel::find());
    }    

    public function adicionarAction()
	{
        $this->assets->addCss('css/chosen.min.css');
        $this->assets->addCss('css/jquery-ui.min.css');

        $this->assets->addJs('js/chosen.jquery.min.js');
        $this->assets->addJs('js/jquery.ui.widget.js');
        $this->assets->addJs('js/jquery.iframe-transport.js');
        $this->assets->addJs('js/jquery.fileupload.js');
        $this->assets->addJs('js/jquery.inputmask.bundle.min.js');
        $this->assets->addJs('js/jquery-ui.min.js');


        $this->view->setVar('tipoimovel', TipoImovel::find());
        $this->view->setVar('filiais', Filial::find());
        $this->view->setVar('logradouros', Logradouro::find(['order'=> 'bairro_id']));

    }
    
    public function editarAction($id)
	{
        echo 'editar';

    }
    
    public function removerAction($id)
	{
        echo 'remover';
    }
    
    public function visualizarAction($id)
	{

        echo 'visualizar';

	}

}
