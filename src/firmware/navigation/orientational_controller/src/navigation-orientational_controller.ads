with Math.Angles;
with Math.Vectors;
with Math.Planes;
with Math.Matrices;
with Math.Quaternions;

with Navigation.Motion_Component;
with Navigation.PID_Controller;
with Navigation.Thrusters;

package Navigation.Orientational_Controller is

   type COrientationalController is tagged private;


   function xCreate (pxCurrentAbsoluteOrientation : access Math.Matrices.CMatrix; pxWantedAbsoluteOrientation : access Math.Matrices.CMatrix; pxCurrentAbsoluteOrientationInverse : access Math.Matrices.CMatrix) return COrientationalController;
   --  <summary>Creates an object of type COrientationalController and sets references to the current and wanted orientation</summary>
   --  <parameter name="pxCurrentAbsoluteOrientation">A reference to the current absolute orientation</parameter>
   --  <parameter name="pxWantedAbsoluteOrientation">A reference to the wanted absolute orientation</parameter>

   procedure Get_Orientational_Thruster_Control_Values (this : in out COrientationalController; fDeltaTime : in float; tfValues : out Navigation.Thrusters.TThrusterEffects);
   --  <summary>Calculates thruster control values for all thrusters and scales them accordingly</summary>
   --  <parameter name="this">The COrientationalController to do the calculations upon.</parameter>
   --  <parameter name="fDeltaTime">The time difference since the last calculation.</parameter>


   procedure Update_Current_Errors (this : in out COrientationalController);
   --  <summary>Cascades the difference between the current orientation and the wanted orientation to all motion components</summary>
   --  <parameter name="this">The COrientationalController object that holds the objects that needs to be updated</parameter>

   procedure Set_New_PID_Component_Scalings(this : in out COrientationalController; eComponentToUpdate : Navigation.Motion_Component.EMotionComponent; xNewPIDScaling : Navigation.PID_Controller.TPIDComponentScalings);
   --  <summary>Sets new component scalings on a PID controller held by the COrientationalController in question</summary>
   --  <parameter name="this">The COrientationalController object that holds the PID controller to update.</parameter>
   --  <parameter name="xNewPIDSCalings">The TPIDComponetScalings object to set for the object.</parameter>
   --  <parameter name="eComponentToChange">The index of the component to change.</parameter>

private

   procedure Update_Current_X_Rotation_Error (this : in out COrientationalController);
   procedure Update_Current_Y_Rotation_Error (this : in out COrientationalController);
   procedure Update_Current_Z_Rotation_Error (this : in out COrientationalController);

   procedure Get_X_Rotation_Thruster_Control_Value (this : in out COrientationalController; fDeltaTime : in float; fControlValue : out float);
   procedure Get_Y_Rotation_Thruster_Control_Value (this : in out COrientationalController; fDeltaTime : in float; fControlValue : out float);
   procedure Get_Z_Rotation_Thruster_Control_Value (this : in out COrientationalController; fDeltaTime : in float; fControlValue : out float);

   type COrientationalController is tagged
      record
         pxCurrentAbsoluteOrientation : access Math.Matrices.CMatrix;
         pxWantedAbsoluteOrientation : access Math.Matrices.CMatrix;
         pxCurrentAbsoluteOrientationInverse : access Math.Matrices.CMatrix;

         xXRotMotionComponent : Navigation.Motion_Component.CMotionComponent;
         xYRotMotionComponent : Navigation.Motion_Component.CMotionComponent;
         xZRotMotionComponent : Navigation.Motion_Component.CMotionComponent;

      end record;

end Navigation.Orientational_Controller;
