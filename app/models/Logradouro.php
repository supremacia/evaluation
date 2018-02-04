<?php

use Phalcon\Mvc\Model;

class Logradouro extends Model
{
    /* Dica: Olhar Schema do Banco de dados para criar os atributos e relacionamentos corretamente */
    public $id;
    
    public function initialize()
    {
        $this->setSource("logradouro");
        $this->hasMany('id', 'Imovel', 'logradouro_id');
        $this->belongsTo('bairro_id', 'Bairro', 'id');
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
