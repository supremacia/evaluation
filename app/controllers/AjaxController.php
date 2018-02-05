<?php

use Phalcon\Mvc\Controller;
use App\Models;
use Phalcon\Image\Factory;

class AjaxController extends Controller
{

	//static error message
	static $error = false;

	/**
	 * Receive the image, process it and send it back.
	 * @todo   save locally and send only the link, with routine to delete the "rubbish" by default. 
	 * @return json base64 encoded data image
	 */
	public function uploadImageAction()
	{
		//exit(print_r($_POST).print_r($_FILES));
		if (isset($_FILES['imagem']['error'])
            && $_FILES['imagem']['error'] == UPLOAD_ERR_OK) {

			$type = $_FILES['imagem']['type'];

			//check type...
           	if($type != 'image/jpeg' && $type != 'image/jpg' && $type != 'image/png'){
           		static::$error = 'Imagem não permitida.';
           		self::sendJson();
           	}
           
        	$filename = md5(uniqid(rand(), true)).'.jpg';
			$filepath = BASE_PATH.'/public/media/temp/'.$filename;
			$fileurl = '/media/temp/'.$filename;

            $a[	'imagem'] = [
               	'name' 	 => $filename,
              	'size' 	 => $_FILES['imagem']['size'],
               	'type' 	 => 'image/jpg',
               	'url'  	 => $fileurl,
               	'status' => 'success'];

               	//Save uploaded file
            	move_uploaded_file($_FILES['imagem']['tmp_name'], $filepath);

				//Resize first, crop after (for max quality, without distortions)
				$image = new \Phalcon\Image\Adapter\Gd($filepath);

				$width   = 800;
				$height  = 450;
				//Resized to 800 x ?
				$image->resize(800, null, \Phalcon\Image::WIDTH);				
				
				$offsetX = (($image->getWidth() - $width) / 2);
				$offsetY = (($image->getHeight() - $height) / 2);

				//Crop to 800 x 450 (16:9)
				$image->crop($width, $height, $offsetX, $offsetY);		

				//save (subscrib)
				$image->save($filepath);

				//enviando a imagem ao browser
				$a['imagem']['imagem'] = 'data:image/jpeg;base64,'.base64_encode(file_get_contents($filepath));

				//new file size
				$a['imagem']['newsize'] = filesize($filepath);

				//apagando o arquivo temporário
				unlink($filepath);
				
				//Send to client
           		self::sendJson($a);
        }
	}


	/**
	 * Validação do código do imóvel
	 * @return json success/error [opcional mesaage]
	 */
	public function validateCodigoAction()
	{
		if(isset($_POST['codigo'])){
			if(!self::codigoExisteAction($_POST['codigo'])){
				self::sendJson();
			}
		}
		static::$error = 'Código já cadastrado.';
        self::sendJson();
	}


	/**
	 * Validação do código do imóvel - no DB (para reutilização)
	 * @return bool true/false 
	 */
	public static function codigoExisteAction($codigo)
	{
		$model = Imovel::find("codigo = '".$codigo."'");
		return !(count($model) == 0);
	}


	//Send data to javascript
	/**
	 * Send json to client side
	 * @param  array  $data array of data t send
	 * @return json         formated json data for http
	 */
	static function sendJson(array $data = [], string $errorMessage = null)
	{
		ob_end_clean();
        ob_start('ob_gzhandler');

        //set new error message
        if($errorMessage !== null) static::$error = $errorMessage;

        //Add params
        if(static::$error !== false) {
        	$data['error'] = static::$error;
        	$data['status'] = 'error';
        } else {
        	$data['status'] = 'success';
        }

        // Encode..
        $data = json_encode($data);
        
        //Send headers
        header('Content-Type: application/json');
        header('Content-Length: ' . strlen($data));
       	
       	//Send Json
		exit($data);
	}

}