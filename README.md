# MoviesCencosud
Prueba Cencosud

Para este proyecto se esta usando MPV como patron de arquitectura y tiene como modulos principales

- Main :  prepara el pagecontrollor y el tabview para el listados.
- PopularMovies: listado de lo mas visto peliculas
- TopRatedMovies: listado de las mejores peliculas
- UpcomingMovies: listado de proximos peliculas
- Detail: Detalle de la pelicula

 capa networking se esta usando Async Awaitt para el llamdo de la api.
 
 Cada clase solo tiene una unica responsabilidad gracias al patron de arquitectura por ejemplo

* las clases ViewControler como PopularMoviesViewController , TopRatedMoviesViewController, UpcomingMoviesViewController ... etc, 
es responsable de la UI o interfaz de usuario.

* las clases presenter como PopularMoviesPresenter, TopRatedPresenter ... etc, 
es responsable de procesar los datos del modelo que va a mostrar el viewcontroller

* las clases provider como PopularMoviesProvider, UpcomingMoviesProvider ... etc,
se encargan de llamar a servicios externos(API) o internos(BD local) 


gestor de dependencia : cocoa pods
pods : Kingfisher
