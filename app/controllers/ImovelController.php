<?php 

use Phalcon\Mvc\Controller;

class ImovelController extends Controller
{
    
    /**
     * Link (relativo ao root) para os arquivos de media (imagens, no caso)
     * @var string
     */
    private $mediaUrl = '/media';


    /**
     * Listagem (com busca  e paginação) dos imóveis
     * @return [type] [description]
     */
	public function listarAction()
	{
        $imoveis = Imovel::find("ativo != 'N'");
        $this->view->setVar('imoveis', $imoveis); 
        $this->view->setVar('tipoimovel', TipoImovel::find());
        $this->view->setVar('menuCadastroActive', 'active');
    }    

    /**
     * Página de adição de imóveis
     * @return [type] [description]
     */
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

        $this->view->setVar('menuCadastroActive', 'active');
        $this->view->setVar('mediaUrl', $this->mediaUrl);

    }

    /**
     * Insert new imovel - via ajax
     * @return json return success/error and error messages
     */
    public function insertAction()
    {
        // criando o model
        $model = new Imovel;
        $model->ativo = 'S';


        //Validações
        
        //Código
        if(isset($_POST['codigo']) && !AjaxController::codigoExisteAction($_POST['codigo'])){
            $model->codigo = $_POST['codigo'];
        } else {
            AjaxController::sendJson(['campo'=>'codigo'], 'Código inválido!');
        }

        //Publicação e data
        $model->publicado = 'N';
        $model->data_expiracao = null;
        if(isset($_POST['publicado']) && isset($_POST['data_expiracao'])){

            $tmp = explode('/', $_POST['data_expiracao']);
            $data_expiracao = strtotime($tmp[2].'-'.$tmp[1].'-'.$tmp[0].' 23:59:59');
            
            if(time() < $data_expiracao){
                $model->data_expiracao = date('Y-m-d', $data_expiracao);
                $model->publicado = 'S';
            } else {
                AjaxController::sendJson(['campo'=>'data_expiracao'],'Data de expiração deve ser após a data de hoje!'.$data_expiracao.' - '.time());
            }
        }

        //Campos diversos e que aceita NULL
        $model->area_terreno    = isset($_POST['area_terreno'])     ? $this->toDouble($_POST['area_terreno']) : null;
        $model->banheiros       = isset($_POST['banheiros'])        ? $_POST['banheiros'] : null;
        $model->dormitorios     = isset($_POST['dormitorios'])      ? $_POST['dormitorios'] : null;
        $model->vagas_garagem   = isset($_POST['vagas_garagem'])    ? $_POST['vagas_garagem'] : null;
        $model->numero          = isset($_POST['numero'])           ? $_POST['numero'] : null;

        $model->descricao = isset($_POST['descricao']) ? $_POST['descricao'] : null;

        //Titulo do imóvel
        if(isset($_POST['titulo_imovel']) && trim($_POST['titulo_imovel']) !== ''){
            $model->titulo_imovel = trim($_POST['titulo_imovel']);
        } else {
            AjaxController::sendJson(['campo'=>'titulo_imovel'],'É necessário um <b>título</b> para a publicação!');
        }

        //Valor e tipo do do negócio 
        if(isset($_POST['tipo_negocio']) && isset($_POST['valor'])){

            switch (trim($_POST['tipo_negocio'])) {
                case 'A':
                    $model->tipo_negocio = 'A';
                    $model->valor_aluguel = $this->toDouble($_POST['valor']);
                    break;
                case 'V':
                    $model->tipo_negocio = 'V';
                    $model->valor_venda = $this->toDouble($_POST['valor']);
                    break;
                
                default:
                    AjaxController::sendJson(['campo'=>'tipo_negocio'],'Indique o <b>tipo de negócio</b>!');
                    break;
            }
        } else {
            AjaxController::sendJson(['campo'=>'valor'],'Indique o <b>valor</b> desse imóvel!');
        }


        //Com chaves para outros models (tabelas)
        $model->logradouro_id   = isset($_POST['logradouro'])   ? $_POST['logradouro'] : null;
        $model->filial_id       = isset($_POST['filial'])       ? $_POST['filial'] : null;
        $model->tipo_imovel_id  = isset($_POST['tipo_imovel'])  ? $_POST['tipo_imovel'] : null;

        //Salvando a imagem e o nome no banco de dados
        // ATT: somente o nome será salvo no banco, caso o caminho seja mudado, não seria necessário alterar TODOS os campos do BD.
        if($model->save()){
            $filename = md5(uniqid(rand(), true)).'.jpg';
            $filepath = BASE_PATH.'/public/media/'.$filename;
            if(isset($_POST['realimagem'])){
                file_put_contents($filepath, base64_decode(str_replace('data:image/jpeg;base64,','',$_POST['realimagem'])));
            }

            $modelImagem = new ImovelImagem();
            $modelImagem->imovel_id = $model->id;
            $modelImagem->caminho = $filename;

            $modelImagem->save();
        } else {
            AjaxController::sendJson(['campo'=>'all'],'Não foi possível salvar esse imóvel!<br>Contate o administrador deste site [cod:01]');
        }       

        AjaxController::sendJson();
    }

    /**
     * Helper - convert to float (double))
     * @param  string $str string with number in portuguese style
     * @return float     float number
     */
    private function toDouble(string $str)
    {
        //retirando os pontos, trocando virgula por ponto (english style :P ) ... 
        $str = str_replace(',','.', str_replace('.','', $str));
        //convertendo...
        return floatval($str);
    }
    

    /**
     * Edição do imóvel
     * @param  [type] $id [description]
     * @return [type]     [description]
     */
    public function editarAction($id)
	{
        echo 'editar';

    }
    

    /**
     * Remoção (soft delete) do imóvel
     * @param  [type] $id [description]
     * @return [type]     [description]
     */
    public function removerAction($id)
	{
        echo 'remover';
    }
    

    /**
     * Visualização do imóvel
     * @param  [type] $id [description]
     * @return [type]     [description]
     */
    public function visualizarAction($id)
	{

        echo 'visualizar';

	}

}
