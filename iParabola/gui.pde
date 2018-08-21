public void checkbox1_clicked1(GCheckbox source, GEvent event) {
  println("checkbox1 - GCheckbox >> GEvent." + event + " @ " + millis());
  showGrid = !showGrid;
}

public void custom_slider1_change1(GCustomSlider source, GEvent event) {
  println("custom_slider1 - GCustomSlider >> GEvent." + event + " @ " + millis());
  lineWeight = custom_slider1.getValueI();
}

public void custom_slider2_change1(GCustomSlider source, GEvent event) {
  println("custom_slider2 - GCustomSlider >> GEvent." + event + " @ " + millis());
  detail = custom_slider2.getValueI();
}

public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle("Sketch Window");
  checkbox1 = new GCheckbox(this, 650, 330, 120, 20);
  checkbox1.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  checkbox1.setText("");
  checkbox1.setTextBold();
  checkbox1.setOpaque(false);
  checkbox1.addEventHandler(this, "checkbox1_clicked1");
  custom_slider1 = new GCustomSlider(this, 650, 180, 150, 40, "grey_blue");
  custom_slider1.setLimits(3, 0, 10);
  custom_slider1.setNbrTicks(10);
  custom_slider1.setStickToTicks(true);
  custom_slider1.setNumberFormat(G4P.INTEGER, 0);
  custom_slider1.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  custom_slider1.setOpaque(false);
  custom_slider1.addEventHandler(this, "custom_slider1_change1");
  custom_slider2 = new GCustomSlider(this, 650, 260, 150, 40, "grey_blue");
  custom_slider2.setLimits(10.0, 0.0, 50.0);
  custom_slider2.setNbrTicks(100);
  custom_slider2.setNumberFormat(G4P.DECIMAL, 1);
  custom_slider2.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  custom_slider2.setOpaque(false);
  custom_slider2.addEventHandler(this, "custom_slider2_change1");
}

GCheckbox checkbox1; 
GCustomSlider custom_slider1;  
GCustomSlider custom_slider2; 
