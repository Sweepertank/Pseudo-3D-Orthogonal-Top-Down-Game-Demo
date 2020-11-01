using Godot;
using System;

public class Level : Node
{
	[Export]
	public int border_left = 0;
	[Export]
	public int border_right = 1024;
	[Export]
	public int border_top = 0;
	[Export]
	public int border_bottom = 1024;
    // Declare member variables here. Examples:
    // private int a = 2;
    // private string b = "text";

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        //Camera2D playerCam = (Camera2D)GetTree().GetNodesInGroup("Player")[0].GetNode("Camera2D");
		Camera2D playerCam = (Camera2D)((Node)GetTree().GetNodesInGroup("Player")[0]).GetNode("Camera2D");
    }

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
}
