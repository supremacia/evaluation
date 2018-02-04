<!DOCTYPE html>
<html>
    <head>
        <title>Avaliação InfoIdéias</title>
        <meta charset="utf-8">
        <link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link type="text/css" rel="stylesheet" href="/css/bootstrap.min.css">
        <link type="text/css" rel="stylesheet" href="/css/styles.css">
        {{ assets.outputCss() }}
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            {{ link_to(['for':'site.inicio'], 'Real State', 'class': 'navbar-brand') }}
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item active">{{ link_to(['for':'site.inicio'], 'Início', 'class':'nav-link') }}</li>
                    <li class="nav-item">{{ link_to(['for':'site.imovel.listar'], 'Cadastro de Imóveis', 'class':'nav-link') }}</li>
                </ul>
            </div>
        </nav>
        {% block content %}{% endblock %}
        <!-- Styles/Scripts-->
        <script type="text/javascript" src="/js/jquery-3.3.1.min.js"></script>
        <script type="text/javascript" src="/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="/js/bootstrap.bundle.min.js"></script>
        <script type="text/javascript" src="/js/scripts.js"></script>
        {{ assets.outputJs() }}
    </body>
</html>