<?php

use Phalcon\Mvc\Model;

class Imovel extends Model
{
    /* Dica: Olhar Schema do Banco de dados para criar os atributos e relacionamentos corretamente */
    public $id;
    
    public function initialize()
    {
        $this->setSource("imovel");
        $this->belongsTo('tipo_imovel_id', 'TipoImovel', 'id');
        $this->belongsTo('filial_id', 'Filial', 'id');
        $this->belongsTo('logradouro_id', 'Logradouro', 'id');
        $this->hasMany('id', 'ImovelImagem', 'imovel_id');        
    }

    public function getId()
    {
        return $this->id;
    }

    public function setId($id)
    {
        $this->id = $id;
    }
}
