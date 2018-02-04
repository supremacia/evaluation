<?php

use Phalcon\Mvc\Model;

class ImovelImagem extends Model
{
    /* Dica: Olhar Schema do Banco de dados para criar os atributos e relacionamentos corretamente */
    public $id;

    public $imovel_id;

    public $caminho;


    public function initialize()
    {
        $this->setSource("imovel_imagem");
        $this->belongsTo('imovel_id', 'Imovel', 'id');
    }

}