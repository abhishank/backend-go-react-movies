package models

import (
	"context"
	"database/sql"
	"fmt"
	"log"
	"time"
)

type DBModel struct {
	DB *sql.DB
}

// returns one movie or error
func (m *DBModel) Get(id int) (*Movie, error) {
	ctx, cancel := context.WithTimeout(context.Background(), 3*time.Second)
	defer cancel()

	query := ` select id, title, description, year, release_date, rating, runtime, mpaa_rating, created_at, updated_at from movies where id=?`

	row := m.DB.QueryRowContext(ctx, query, id)

	var movie Movie

	err := row.Scan(
		&movie.ID,
		&movie.Title,
		&movie.Description,
		&movie.Year,
		&movie.ReleaseDate,
		&movie.Rating,
		&movie.Runtime,
		&movie.MPAARating,
		&movie.CreatedAt,
		&movie.UpdatedAt,
	)

	if err != nil {
		fmt.Print(err.Error())
		return nil, err
	}

	query = `select movies_genres.id, genres.genre_name from genres 
	left join movies_genres on genres.id = movies_genres.genre_id 
	where movies_genres.movie_id = ?`

	col, err := m.DB.QueryContext(ctx, query, id)
	if err != nil {
		return nil, err
	}
	defer col.Close()

	genre := make(map[int]string)
	for col.Next() {
		var movieGenre MovieGenre
		err := col.Scan(&movieGenre.ID, &movieGenre.Genre.GenreName)
		if err != nil {
			fmt.Print(err.Error())
			return nil, err
		}
		log.Println(movieGenre.Genre.GenreName)
		genre[movieGenre.ID] = movieGenre.Genre.GenreName
	}

	movie.MovieGenre = genre

	return &movie, nil
}

// returns all movie or error
func (m *DBModel) All() ([]*Movie, error) {
	ctx, cancel := context.WithTimeout(context.Background(), 3*time.Second)
	defer cancel()

	query := ` select id, title, description, year, release_date, rating, runtime,
				 mpaa_rating, created_at, updated_at from movies order by title`

	rows, err := m.DB.QueryContext(ctx, query)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var movies []*Movie

	for rows.Next() {
		var movie Movie
		err := rows.Scan(
			&movie.ID,
			&movie.Title,
			&movie.Description,
			&movie.Year,
			&movie.ReleaseDate,
			&movie.Rating,
			&movie.Runtime,
			&movie.MPAARating,
			&movie.CreatedAt,
			&movie.UpdatedAt,
		)
		if err != nil {
			fmt.Println(err.Error())
			return nil, err
		}

		queryGenre := `select movies_genres.id, genres.genre_name from genres 
	left join movies_genres on genres.id = movies_genres.genre_id 
	where movies_genres.movie_id = ?`

		genreRows, err := m.DB.QueryContext(ctx, queryGenre, movie.ID)
		if err != nil {
			return nil, err
		}
		genre := make(map[int]string)
		for genreRows.Next() {
			var movieGenre MovieGenre
			err := genreRows.Scan(&movieGenre.ID, &movieGenre.Genre.GenreName)
			if err != nil {
				return nil, err
			}
			genre[movieGenre.ID] = movieGenre.Genre.GenreName
		}
		genreRows.Close()
		movie.MovieGenre = genre

		movies = append(movies, &movie)
	}

	return movies, nil
}
