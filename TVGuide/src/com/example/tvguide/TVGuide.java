package com.example.tvguide;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;

import android.app.AlertDialog;
import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.os.StrictMode;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;

public class TVGuide extends ListActivity {
	private TextView selection;
	private ArrayList<Show> shows = new ArrayList<Show>();

	/** Called when the activity is first created. */
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.setContentView(R.layout.main);

		StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder()
				.permitAll().build();
		StrictMode.setThreadPolicy(policy);

		try {
			URL url = new URL("http://www.epguides.com/common/allshows.txt");
			BufferedReader in = new BufferedReader(new InputStreamReader(
					url.openStream()));
			ArrayList<String> lines = new ArrayList<String>();
			String line_;
			while ((line_ = in.readLine()) != null) {
				lines.add(line_);
			}
			in.close();
			lines.remove(0);
			ArrayList<String> favorites = new ArrayList<String>();
			favorites.add("Aliens in America");
			favorites.add("Boardwalk Empire");
			favorites.add("Da Ali G Show");
			favorites.add("Eastbound & Down");
			favorites.add("Entourage");
			favorites.add("Family Guy");
			favorites.add("Hung");
			favorites.add("Little Mosque on the Prairie");
			favorites.add("Mad Men");
			favorites.add("Mind Your Language");
			favorites.add("Modern Family");
			favorites.add("Outsourced");
			favorites.add("The Boondocks");
			favorites.add("The Cleveland Show");
			favorites.add("The League");
			favorites.add("The Office");
			favorites.add("Weeds");
			for (String line : lines) {
				line = line.trim();
				if (line.length() > 0) {
					String[] values = line.split("\",");
					String showName = values[0].substring(1);
					String showId = values[1].split(",")[1];
					Show show = new Show(showName, showId);
					if (favorites.contains(showName)) {
						this.shows.add(show);
					}
				}
			}
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		this.setListAdapter(new ArrayAdapter<Show>(this,
				android.R.layout.simple_list_item_1, this.shows));
		this.selection = (TextView) this.findViewById(R.id.selection);
		this.selection.setText("Welcome");
	}

	public void onListItemClick(ListView l, View v, int position, long id) {
		Show show = this.shows.get(position);
		if (show.getId().length() > 0) {
			Intent intent = new Intent(this, ShowGuide.class);
			intent.putExtra("id", show.getId());
			intent.putExtra("name", show.toString());
			this.startActivity(intent);
		} else {
			new AlertDialog.Builder(this).setTitle("Error")
					.setMessage("No show ID").setNeutralButton("Okay", null)
					.show();
		}
	}
}