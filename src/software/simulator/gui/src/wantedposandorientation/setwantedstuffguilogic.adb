with Gtk.Main;
with Glib.Main;
with Gtk.Combo_Box;
with Gtk.GEntry;

with Gdk;
with Gdk.Window;
with Gdk.GC;
with Gdk.Color;
with Gdk.Font;
with Gtk.Widget;
with Gtk.Drawing_Area;
with Gdk.Drawable;
with Ada.Text_IO;

package body SetWantedStuffGUILogic is

   procedure Update_Wanted_Position(pxObject : access Gtkada.Builder.Gtkada_Builder_Record'Class) is
      sPositionX : Gtk.GEntry.Gtk_Entry := Gtk.GEntry.Gtk_Entry(Gtkada.Builder.Get_Widget(pxObject, "entryXPos"));
      sPositionY : Gtk.GEntry.Gtk_Entry := Gtk.GEntry.Gtk_Entry(Gtkada.Builder.Get_Widget(pxObject, "entryYPos"));
      sPositionZ : Gtk.GEntry.Gtk_Entry := Gtk.GEntry.Gtk_Entry(Gtkada.Builder.Get_Widget(pxObject, "entryZPos"));

      sRotationX : Gtk.GEntry.Gtk_Entry := Gtk.GEntry.Gtk_Entry(Gtkada.Builder.Get_Widget(pxObject, "entryXRot"));
      sRotationY : Gtk.GEntry.Gtk_Entry := Gtk.GEntry.Gtk_Entry(Gtkada.Builder.Get_Widget(pxObject, "entryYRot"));
      sRotationZ : Gtk.GEntry.Gtk_Entry := Gtk.GEntry.Gtk_Entry(Gtkada.Builder.Get_Widget(pxObject, "entryZRot"));
   begin
      Ada.Text_IO.Put_Line("Updating wanted pos and orientation");

      xViewmodel.Set_Wanted_Position_And_Orientation(fPositionX    => Float'Value(sPositionX.Get_Text),
                                                     fPositionY    => Float'Value(sPositionY.Get_Text),
                                                     fPositionZ    => Float'Value(sPositionZ.Get_Text),
                                                     fRotationX => Float'Value(sRotationX.Get_Text),
                                                     fRotationY => Float'Value(sRotationY.Get_Text),
                                                     fRotationZ => Float'Value(sRotationZ.Get_Text));
   exception
      when E : others =>
         Ada.Text_IO.Put_Line("ABO");
   end Update_Wanted_Position;


end SetWantedStuffGUILogic;
