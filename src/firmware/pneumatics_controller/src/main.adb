-- Written by: Konstantinos Konstantopoulos for the Naiad AUV project
-- Last changed (yyyy-mm-dd): 2013-10-11

with Pneumatics;
with AVR.AT90CAN128.CAN;
with AVR.AT90CAN128.CLOCK;
with CAN_Defs;

procedure Main is

   canReceivedMsg : AVR.AT90CAN128.CAN.CAN_Message;
   msgReceived	: Boolean;
   myResult : Pneumatics.Controller_Response;

   use type AVR.AT90CAN128.CAN.CAN_ID;

begin

   AVR.AT90CAN128.CAN.Can_Init(AVR.AT90CAN128.CAN.K250);
   AVR.AT90CAN128.CAN.Can_Enable;

   AVR.AT90CAN128.CAN.Can_Set_MOB_ID_MASK(1, (10, False), (16#7FF#, False));
   AVR.AT90CAN128.CAN.Can_Set_MOB_ID_MASK(2, (11, False), (16#7FF#, False));
   AVR.AT90CAN128.CAN.Can_Set_MOB_ID_MASK(3, (16, False), (16#7FF#, False));

   Pneumatics.Init_Pins;

   loop
      AVR.AT90CAN128.CAN.Can_Get(canReceivedMsg, msgReceived, AVR.AT90CAN128.CLOCK.Time_Duration(-1));

      if msgReceived then

         if AVR.AT90CAN128.CAN."="(canReceivedMsg.ID.Identifier, CAN_Defs.MSG_KILL_SWITCH_ID.Identifier) then
            Pneumatics.Dispatch_Kill_Msg(canReceivedMsg, myResult);
         elsif AVR.AT90CAN128.CAN."="(canReceivedMsg.ID.Identifier, CAN_Defs.MSG_SIMULATION_MODE_ID.Identifier) then
            Pneumatics.Dispatch_Sim_Msg(canReceivedMsg, myResult);
         elsif AVR.AT90CAN128.CAN."="(canReceivedMsg.ID.Identifier, CAN_Defs.MSG_PNEUMATICS_ID.Identifier) then
            if Pneumatics.bKillSwitchFlag = False then
               Pneumatics.Dispatch_Actuation_msg(canReceivedMsg, myResult);
            else
               --Debug: Kill Switch is active
               myResult.success := True;
               myResult.canMsgOut := (ID =>(Identifier => 255,isExtended => False), Len => 1, Data => (101, others => 0) );
            end if;
         else
            --myResult.success := False;

            --Debug unknown ID
            myResult.success := True;
            myResult.canMsgOut := (ID =>(Identifier => 255,isExtended => False), Len => 1, Data => (111, others => 0) );
         end if;

         if myResult.success then
            myResult.success := False;
            AVR.AT90CAN128.CAN.Can_Send(myResult.canMsgOut);
         else
            -- Debug success is false
            --myResult.canMsgOut := (ID => 255, Len => 1, Data => (121, others => 0) );
            AVR.AT90CAN128.CAN.Can_Send(canReceivedMsg);
         end if;

      end if;

   end loop;

end Main;
