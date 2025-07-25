include <bins.scad>

render()
  difference() {
    pegstr();

    // double width
    bin_interior(5.5, 0);
	
    bin_interior(3.5, 1);
    bin_interior(5.5, 1);

    bin_interior(0.5, 2);
    bin_interior(2.5, 2);
    bin_interior(4.5, 2);
    bin_interior(6.5, 2);

    // double depth

    bin_height(row=1, h=65);
    bin_height(row=2, h=25);
  }
