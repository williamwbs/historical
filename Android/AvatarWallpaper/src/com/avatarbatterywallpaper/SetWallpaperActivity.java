package com.avatarbatterywallpaper;

import com.avatarbatterywallpaper.R;
import com.wallpapers.AdultAang;
import com.wallpapers.AvatarState;
import com.wallpapers.KorraPurifyingCity;
import com.wallpapers.KorraPurifyingSpirit;
import com.wallpapers.KorraSpirit;
import com.wallpapers.SpiritBend;
import com.wallpapers.Toph;
import com.wallpapers.Wan;

import android.os.Bundle;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.WallpaperManager;
import android.content.ComponentName;
import android.content.Intent;
import android.view.Menu;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.CompoundButton.OnCheckedChangeListener;
import android.widget.Toast;

public class SetWallpaperActivity extends Activity implements OnClickListener {

	private static final int REQUEST_SET_LIVE_WALLPAPER = 101;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_set_wallpaper);

		((View)findViewById(R.id.btnAvatarState)).setOnClickListener(this);
		((View)findViewById(R.id.btnSpiritBend)).setOnClickListener(this);
		((View)findViewById(R.id.btnAdultAang)).setOnClickListener(this);
		((View)findViewById(R.id.btnWan)).setOnClickListener(this);
		((View)findViewById(R.id.btnToph)).setOnClickListener(this);
		((View)findViewById(R.id.btnKorraPurifyingCity)).setOnClickListener(this);
		((View)findViewById(R.id.btnKorraPurifyingSpirit)).setOnClickListener(this);
		((View)findViewById(R.id.btnKorraSpirit)).setOnClickListener(this);
		
		CheckBox alwaysCentralized = (CheckBox)findViewById(R.id.chkAlwaysCentralized);
		alwaysCentralized.setChecked(AvatarApplication.getAlwaysCentralized());
		
		alwaysCentralized.setOnCheckedChangeListener(new OnCheckedChangeListener() {
			
			@Override
			public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
				AvatarApplication.setAlwaysCentralized(isChecked);
				
			}
		});
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.set_wallpaper, menu);
		return true;
	}

	@SuppressLint("InlinedApi")
	@Override
	public void onClick(View v) {
		Intent intent = null;
		
		try
		{
			ComponentName component = null;
			switch (v.getId()) {
			case R.id.btnAvatarState:
				component = new ComponentName(this, AvatarState.class);
				break;
			case R.id.btnSpiritBend:
				component = new ComponentName(this, SpiritBend.class);
				break;
			case R.id.btnAdultAang:
				component = new ComponentName(this, AdultAang.class);
				break;
			case R.id.btnToph:
				component = new ComponentName(this, Toph.class);
				break;
			case R.id.btnWan:
				component = new ComponentName(this, Wan.class);
				break;
			case R.id.btnKorraPurifyingSpirit:
				component = new ComponentName(this, KorraPurifyingSpirit.class);
				break;
			case R.id.btnKorraSpirit:
				component = new ComponentName(this, KorraSpirit.class);
				break;
			case R.id.btnKorraPurifyingCity:
				component = new ComponentName(this, KorraPurifyingCity.class);
				break;
			default:
				return;
			}
			
			intent = new Intent(WallpaperManager.ACTION_CHANGE_LIVE_WALLPAPER);
			intent.putExtra(WallpaperManager.EXTRA_LIVE_WALLPAPER_COMPONENT, component);
			startActivityForResult(intent, REQUEST_SET_LIVE_WALLPAPER);
		}
		catch (android.content.ActivityNotFoundException e3)
		{
			// try the generic android wallpaper chooser next
			try 
			{
				intent = new Intent(WallpaperManager.ACTION_LIVE_WALLPAPER_CHOOSER);
				startActivityForResult(intent, REQUEST_SET_LIVE_WALLPAPER);
				
				Toast.makeText(this, "Escolha seu Wallpaper", Toast.LENGTH_LONG).show();
			} 
			catch (android.content.ActivityNotFoundException e2) 
			{
				// that failed, let's try the nook intent
				try 
				{
					intent = new Intent();
					intent.setAction("com.bn.nook.CHANGE_WALLPAPER");
					startActivity(intent);
				} 
				catch (android.content.ActivityNotFoundException e) 
				{
					// everything failed, let's notify the user
					Toast.makeText(this, R.string.wallpaperLoadError, Toast.LENGTH_SHORT).show();
				}
			}
		}
	}
}
