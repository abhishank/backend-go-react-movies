package main

import (
	"net/http"

	"github.com/julienschmidt/httprouter"
)

func (app *application) routes() http.Handler {
	router := httprouter.New()

	router.HandlerFunc(http.MethodGet, "/status", app.statusHandler)

	router.HandlerFunc(http.MethodGet, "/v1movie/:id", app.getOneMovie)
	router.HandlerFunc(http.MethodGet, "/v1movies/", app.getAllMovies)

	return app.enableCORS(router)
}
