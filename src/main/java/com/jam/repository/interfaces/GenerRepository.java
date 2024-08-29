package com.jam.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.jam.repository.model.Genre;
@Mapper
public interface GenerRepository {
	public void insertGenre(Genre genre);
	public Genre selectGenreById(int genreId);
	public List<Genre> selectAllGenres();
}
