with AVR.AT90CAN128.INTERRUPT;
with interfaces;

package body AVR.AT90CAN128.CLOCK is
   pragma Suppress (All_Checks);

   Time_Of_Day : Time := 0;
   Waiting     : Boolean := False;
   pragma Volatile (Waiting);
   Delay_Time  : Time;


   function getClockTime return Time is
      Result : Time;
   begin
      AVR.AT90CAN128.INTERRUPT.disableInterrupt;
      Result := Time_Of_Day;
      AVR.AT90CAN128.INTERRUPT.enableInterrupt;
      return Result;
   end getClockTime;


   procedure Init is
   begin

      AVR.AT90CAN128.INTERRUPT.disableInterrupt;
      -- Using Timer 0 for Tick
      TCCR0A := 2#00001011#;   -- CTC Mode    -- Div64 Prescaler
      OCR0A := 250; -- 16MHz and 64 prescaler gives 1ms
      TCNT0 := 0;            -- Initial value
      TIMSK0.Bit_1 := true ;      --Timer 0 Interrupt
      AVR.AT90CAN128.INTERRUPT.enableInterrupt;

   end Init;

   procedure Timer;
   pragma Machine_Attribute (Timer, "signal");
   pragma Export (C, Timer, Vector_Timer0_Comp);

   procedure Timer is
      One : constant Time := 1;
   begin
      Time_Of_Day := Time_Of_Day + One;
      if Waiting then
         Waiting := Time_Of_Day < Delay_Time;
      end if;
   end Timer;

   function "+" (Left : Time; Right : Time_Duration) return Time is
      --use Interfaces;
   begin
      if Right < 0 then
         if Left >= Time(-Right) then
            return Left-Time(-Right);
         else
            return 0;
         end if;
      else
         return Left + Time (Right);
      end if;
   end "+";

   function "+" (Left : Time_Duration; Right : Time) return Time is
   begin
      return Right+Left;
   end "+";

   function "-" (Left : Time; Right : Time_Duration) return Time is
   begin
      return Left + (-Right);
   end "-";

   function "-" (Left : Time; Right : Time) return Time_Duration is
      --use Interfaces;
   begin
      if Left > Right then
         return Time_Duration (Unsigned_32(Left)-Unsigned_32(Right));
      else
         return -Time_Duration (Unsigned_32(Right)-Unsigned_32(Left));
      end if;
   end "-";

   function "<"  (Left, Right : Time) return Boolean is
      --use Interfaces;
   begin
      return Unsigned_32(Left) < Unsigned_32(Right);
   end "<";

   function "<=" (Left, Right : Time) return Boolean is
      --use Interfaces;
   begin
      return Unsigned_32(Left) <= Unsigned_32(Right);
   end "<=";

   function ">"  (Left, Right : Time) return Boolean is
      --use Interfaces;
   begin
      return Unsigned_32(Left) > Unsigned_32(Right);
   end ">";

   function ">=" (Left, Right : Time) return Boolean is
      --use Interfaces;
   begin
      return Unsigned_32(Left) >= Unsigned_32(Right);
   end ">=";

   procedure Delay_Ms (T : Time_Duration) is
      Tau : constant Time := getClockTime + T;
   begin
      Delay_Until (Tau);
   end Delay_MS;

   procedure Delay_Until (T : Time) is
   begin
      Delay_Time := T;
      Waiting := True;
      while Waiting loop
         null;
      end loop;
   end Delay_Until;

   begin
      Clock.Init;
end AVR.AT90CAN128.CLOCK;


