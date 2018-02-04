<?php

use Phalcon\Mvc\Model;

class TipoImovel extends Model
{
    /* Dica: Olhar Schema do Banco de dados para criar os atributos e relacionamentos corretamente */
    public $id;
    
    public function initialize()
    {
        $this->setSource("tipo_imovel");
        $this->hasMany('id', 'Imovel', 'tipo_imovel_id');
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
