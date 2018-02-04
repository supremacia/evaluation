<?php

use Phalcon\Mvc\Model;

class Filial extends Model
{
    /* Dica: Olhar Schema do Banco de dados para criar os atributos e relacionamentos corretamente */
    public $id;
    
    public function initialize()
    {
        $this->setSource("filial");
        $this->hasMany( 'id', 'Imovel', 'filial_id');
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
