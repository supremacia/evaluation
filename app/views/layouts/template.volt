<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="utf-8"> 
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Avaliação InfoIdéias</title>

        <link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link type="text/css" rel="stylesheet" href="/css/bootstrap.min.css">
        <link type="text/css" rel="stylesheet" href="/css/styles.css">
        {{ assets.outputCss() }}
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">               
            
                {{ link_to(['for':'site.inicio'], 'Real State', 'class': 'navbar-brand') }}

                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item {{ menuInicioActive }}">{{ link_to(['for':'site.inicio'], 'Início', 'class':'nav-link') }}</li>
                        <li class="nav-item {{ menuCadastroActive }}">{{ link_to(['for':'site.imovel.listar'], 'Cadastro de Imóveis', 'class':'nav-link')}}</li>
                    </ul>
                </div>
            </div>
        </nav>
        {% block content %}{% endblock %}
        <!-- Scripts-->

        <!-- sending ROUTES to javascript enviroment --> 
        <script>
            const UPIMGURL  = "{{ url(['for':'site.ajax.image'])}}"; 
            const URLSAVE   = "{{ url(['for':'site.imovel.insert'])}}";
            const URLVALCOD = "{{ url(['for':'site.ajax.validar.codigo'])}}";
            const URLLIST   = "{{ url(['for':'site.imovel.listar'])}}";
        </script>
        <script type="text/javascript" src="/js/jquery-3.3.1.min.js"></script>
        <script type="text/javascript" src="/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="/js/bootstrap.bundle.min.js"></script>
        <script type="text/javascript" src="/js/scripts.js"></script>
        {{ assets.outputJs() }}
    </body>
</html>