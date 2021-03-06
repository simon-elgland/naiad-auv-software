pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;

package stddef_h is

   --  unsupported macro: NULL __null
   --  arg-macro: procedure offsetof (TYPE, MEMBER)
   --    __builtin_offsetof (TYPE, MEMBER)
   subtype ptrdiff_t is long;  -- /usr/gnat/lib/gcc/x86_64-pc-linux-gnu/4.7.4/include/stddef.h:150

   subtype size_t is unsigned_long;  -- /usr/gnat/lib/gcc/x86_64-pc-linux-gnu/4.7.4/include/stddef.h:213

   subtype wint_t is unsigned;  -- /usr/gnat/lib/gcc/x86_64-pc-linux-gnu/4.7.4/include/stddef.h:354

end stddef_h;
