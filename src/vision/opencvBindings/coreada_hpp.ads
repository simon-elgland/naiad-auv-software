pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;

package coreAda_hpp is

   procedure appendImg_Wrap (src : Interfaces.C.Strings.chars_ptr);  -- coreAda.hpp:5
   pragma Import (CPP, appendImg_Wrap, "_Z14appendImg_WrapPc");

   procedure cvtColor_Wrap
     (src : int;
      dst : int;
      filter : int);  -- coreAda.hpp:7
   pragma Import (CPP, cvtColor_Wrap, "_Z13cvtColor_Wrapiii");

   procedure Canny_Wrap
     (src : int;
      dst : int;
      lThresh : int;
      hThresh : int;
      kernelSize : int);  -- coreAda.hpp:9
   pragma Import (CPP, Canny_Wrap, "_Z10Canny_Wrapiiiii");

   procedure imshow_Wrap (name : Interfaces.C.Strings.chars_ptr; src : int);  -- coreAda.hpp:11
   pragma Import (CPP, imshow_Wrap, "_Z11imshow_WrapPci");

   procedure waitKey_Wrap;  -- coreAda.hpp:13
   pragma Import (CPP, waitKey_Wrap, "_Z12waitKey_Wrapv");

   procedure imread_Wrap (name : Interfaces.C.Strings.chars_ptr);  -- coreAda.hpp:15
   pragma Import (CPP, imread_Wrap, "_Z11imread_WrapPc");

   function imwrite_Wrap (name : Interfaces.C.Strings.chars_ptr; src : int) return int;  -- coreAda.hpp:17
   pragma Import (CPP, imwrite_Wrap, "_Z12imwrite_WrapPci");

   function size_Wrap return int;  -- coreAda.hpp:19
   pragma Import (CPP, size_Wrap, "_Z9size_Wrapv");

end coreAda_hpp;
