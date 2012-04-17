package com.example.tvguide;

public class Show {
	private String name;
	private String id;

	public Show(String name, String id) {
		this.name = name;
		this.id = id;
	}

	public String getId() {
		return this.id;
	}

	public String toString() {
		return this.name;
	}
}