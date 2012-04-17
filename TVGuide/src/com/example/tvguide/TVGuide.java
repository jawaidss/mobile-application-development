package com.example.tvguide;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;

import android.app.AlertDialog;
import android.app.ListActivity;
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
			for (String line : lines) {
				line = line.trim();
				if (line.length() > 0) {
					String[] values = line.split("\",");
					String showName = values[0].substring(1);
					String showId = values[1].split(",")[1];
					Show show = new Show(showName, showId);
					this.shows.add(show);
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
	}

	public void onListItemClick(ListView l, View v, int position, long id) {
		String showId = this.shows.get(position).getId();
		if (showId.length() > 0) {
			this.selection.setText(showId);
		} else {
			new AlertDialog.Builder(this).setTitle("Error")
					.setMessage("No show ID").setNeutralButton("Okay", null)
					.show();
		}
	}
}