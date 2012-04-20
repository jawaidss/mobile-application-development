package com.example.tvguide;

public class Episode {
	private String season;
	private String episode;
	private String airdate;
	private String title;

	public Episode(String season, String episode, String airdate, String title) {
		this.season = season;
		this.episode = episode;
		this.airdate = airdate;
		this.title = title;
	}

	public String getDescription() {
		return "Season " + this.season + "\nEpisode " + this.episode + "\n"
				+ this.airdate;
	}

	public String toString() {
		return this.title;
	}
}