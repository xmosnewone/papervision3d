﻿/*
 *  PAPER    ON   ERVIS  NPAPER ISION  PE  IS ON  PERVI IO  APER  SI  PA
 *  AP  VI  ONPA  RV  IO PA     SI  PA ER  SI NP PE     ON AP  VI ION AP
 *  PERVI  ON  PE VISIO  APER   IONPA  RV  IO PA  RVIS  NP PE  IS ONPAPE
 *  ER     NPAPER IS     PE     ON  PE  ISIO  AP     IO PA ER  SI NP PER
 *  RV     PA  RV SI     ERVISI NP  ER   IO   PE VISIO  AP  VISI  PA  RV3D
 *  ______________________________________________________________________
 *  papervision3d.org � blog.papervision3d.org � osflash.org/papervision3d
 */

/*
 * Copyright 2006 (c) Carlos Ulloa Matesanz, noventaynueve.com.
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */

// ______________________________________________________________________
//                                                       MaterialObject3D

package org.papervision3d.core.proto
{
import flash.geom.Matrix;
import flash.display.BitmapData;

/**
* The MaterialObject3D class collects data about how objects appear when rendered.
*
* A material is data that you assign to objects or faces, so that they appear a certain way when rendered. Materials affect the line and fill colors.
*
* Materials create greater realism in a scene. A material describes how an object reflects or transmits light. You assign materials to individual objects or a selection of faces; a single object can contain different materials.
*
*/
public class MaterialObject3D
{
	/**
	* A transparent or opaque BitmapData texture.
	*/
	public var bitmap :BitmapData;

	/**
	* A Boolean value that determines whether the texture is animated.
	*
	* If set, the material must be push()ed into the scene so the BitmapData texture can be updated when rendering. The default value is false, which is sligtly faster.
	*/
	public var animated :Boolean;

	/**
	* A Boolean value that determines whether the BitmapData texture is smoothed when rendered.
	*/
	public var smooth :Boolean;


	/**
	* A RGB color value to draw the triangle's outline.
	*/
	public var lineColor :Number;

	/**
	* An 8-bit alpha value for the triangle's outline. If zero, no outline is drawn.
	*/
	public var lineAlpha :Number;


	/**
	* A RGB color value to fill the triangle with. Only used if no texture is provided.
	*/
	public var fillColor :Number;

	/**
	* An 8-bit alpha value fill the triangle with. If this value is zero and no texture is provided or is undefined, a fill is not created.
	*/
	public var fillAlpha :Number;

	/**
	* A Boolean value that indicates whether the triangle is double sided.
	*/
	public function get doubleSided():Boolean
	{
		return ! this.oneSide;
	}

	public function set doubleSided( double:Boolean ):void
	{
		this.oneSide = ! double;
	}

	/**
	* A Boolean value that indicates whether the triangle is single sided.
	*/
	public var oneSide :Boolean;


	/**
	* A Boolean value that indicates whether the triangle is invisible (not drawn).
	*/
	public var invisible :Boolean;

	/**
	* A Boolean value that indicates whether the triangle is flipped.
	*/
	public var opposite :Boolean;

	/**
	* The scene where the object belongs.
	*/
	public var scene :SceneObject3D;

	/**
	* Default color used for debug.
	*/
	static public var DEFAULT_COLOR :Number = 0xFF00FF;

	/**
	* An optional object name.
	*/
	public var name :String;

	/**
	* [read-only] Unique id of this instance.
	*/
	public var id :Number;

	/**
	* @param	bitmap		A BitmapData texture.
	* @param	lineColor	An RGB color value to draw the triangle's outline.
	* @param	lineAlpha	An alpha value for the triangle's outline.
	* @param	fillColor	An RGB color value to fill the triangle with. Only used if no texture is provided.
	* @param	fillAlpha	An alpha value for the triangle's fill. Only used if no texture is provided.
	* @param	animated	A Boolean value that determines whether the texture is animated.
	*/
	public function MaterialObject3D( initObject:Object=null )
	{
		if( initObject && initObject.bitmap ) this.bitmap = initObject.bitmap;

		// Color
		this.lineColor = initObject? initObject.lineColor || DEFAULT_COLOR : DEFAULT_COLOR;
		this.lineAlpha = initObject? initObject.lineAlpha || 0 : 0;

		this.fillColor = initObject? initObject.fillColor || DEFAULT_COLOR : DEFAULT_COLOR;
		this.fillAlpha = initObject? initObject.fillAlpha || 0 : 0;

		this.animated  = initObject? initObject.animated || false : false;

		// Defaults
		this.invisible = initObject? initObject.invisible || false : false;
		this.smooth    = initObject? initObject.smooth    || false : false;

		this.doubleSided = initObject? initObject.doubleSided || false : false;
		this.opposite = initObject? initObject.opposite || false : false;

		this.id = _totalMaterialObjects++;
	}


	/**
	* Returns a MaterialObject3D object with the default magenta wireframe values.
	*
	* @return A MaterialObject3D object.
	*/
	static public function get DEFAULT():MaterialObject3D
	{
		var defMaterial :MaterialObject3D = new MaterialObject3D();

		defMaterial.lineColor   = DEFAULT_COLOR;
		defMaterial.lineAlpha   = 100;
		defMaterial.fillColor   = DEFAULT_COLOR;
		defMaterial.fillAlpha   = 10;
		defMaterial.doubleSided = true;

		return defMaterial;
	}


	/**
	* Updates animated MovieClip bitmap.
	*
	* Draws the current MovieClip image onto bitmap.
	*/
	public function updateBitmap():void {}


	public function copy( material :MaterialObject3D ):void
	{
		this.bitmap    = material.bitmap;
		this.animated  = material.animated;
		this.smooth    = material.smooth;

		this.lineColor = material.lineColor;
		this.lineAlpha = material.lineAlpha;
		this.fillColor = material.fillColor;
		this.fillAlpha = material.fillAlpha;

		this.oneSide   = material.oneSide;
		this.opposite   = material.opposite;

		this.invisible = material.invisible;
		this.scene     = material.scene;
		this.name      = material.name;
	}


	public function clone():MaterialObject3D
	{
		var cloned:MaterialObject3D = new MaterialObject3D();

		cloned.bitmap    = this.bitmap;
		cloned.animated  = this.animated;
		cloned.smooth    = this.smooth;

		cloned.lineColor = this.lineColor;
		cloned.lineAlpha = this.lineAlpha;
		cloned.fillColor = this.fillColor;
		cloned.fillAlpha = this.fillAlpha;

		cloned.oneSide   = this.oneSide;
		cloned.opposite  = this.opposite;

		cloned.invisible = this.invisible;
		cloned.scene     = this.scene;
		cloned.name      = this.name;

		return cloned;
	}

	/**
	* Returns a string value representing the material properties in the specified MaterialObject3D object.
	*
	* @return	A string.
	*/
	public function toString():String
	{
		return '[MaterialObject3D] bitmap:' + this.bitmap + ' lineColor:' + this.lineColor + ' fillColor:' + fillColor;
	}

	static private var _totalMaterialObjects :Number = 0;
}
}