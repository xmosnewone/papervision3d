/*
 *  PAPER    ON   ERVIS  NPAPER ISION  PE  IS ON  PERVI IO  APER  SI  PA
 *  AP  VI  ONPA  RV  IO PA     SI  PA ER  SI NP PE     ON AP  VI ION AP
 *  PERVI  ON  PE VISIO  APER   IONPA  RV  IO PA  RVIS  NP PE  IS ONPAPE
 *  ER     NPAPER IS     PE     ON  PE  ISIO  AP     IO PA ER  SI NP PER
 *  RV     PA  RV SI     ERVISI NP  ER   IO   PE VISIO  AP  VISI  PA  RV3D
 *  ______________________________________________________________________
 *  papervision3d.org + blog.papervision3d.org + osflash.org/papervision3d
 */

/*
 * Copyright 2006-2007 (c) Carlos Ulloa Matesanz, noventaynueve.com.
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
 
package org.papervision3d.animation.curves
{
	import org.papervision3d.Papervision3D;
	import org.papervision3d.core.Matrix3D;
	
	/**
	 * @author Tim Knip 
	 */
	public class AbstractCurve 
	{
		public static const INTERPOLATION_STEP:uint = 0; //equivalent to no interpolation
		public static const INTERPOLATION_LINEAR:uint = 1;
		public static const INTERPOLATION_BEZIER:uint = 2;
		public static const INTERPOLATION_TCB:uint = 3;
		public static const INTERPOLATION_UNKNOWN:uint = 4;
		public static const INTERPOLATION_DEFAULT:uint = 0;
		
		public static const INFINITY_CONSTANT:uint = 0;
		public static const INFINITY_LINEAR:uint = 1;
		public static const INFINITY_CYCLE:uint = 2;
		public static const INFINITY_CYCLE_RELATIVE:uint = 3;
		public static const INFINITY_OSCILLATE:uint = 4;
		public static const INFINITY_UNKNOWN:uint = 5;
		public static const INFINITY_DEFAULT:uint = 0;
		
		/** */
		public var type:String;
		
		/** curve keys as milliseconds. */
		public var keys:Array;
		
		/** curve key values */
		public var values:Array;
		
		/** */
		public var preInfinity:uint = 0;
		
		/** */
		public var postInfinity:uint = 0;
		
		/** */
		public var interpolationType:uint = INTERPOLATION_LINEAR;
		
		/**
		 * constructor.
		 * 
		 * @param	keys
		 * @param	values
		 * @param	interpolations
		 * 
		 * @return
		 */
		public function AbstractCurve( type:String, keys:Array = null, values:Array = null, interpolations:Array = null ):void
		{
			this.type = type;
			this.keys = keys || new Array();
			this.values = values || new Array();
		}
		
		/**
		 * main workhorse for the animation system.
		 * 
		 * @param	time
		 * 
		 * @return
		 */
		public function evaluate( dt:Number ):Number
		{
			// Check for empty curves and poses (curves with 1 key).
			if( !this.keys.length ) return 0.0;
			if( this.keys.length == 1 ) return this.values[0];
			
			var i:int;
			var outputStart:Number = this.values[0];
			var outputEnd:Number = this.values[this.values.length-1];
			var inputStart:Number = this.keys[0];
			var inputEnd:Number = this.keys[this.keys.length-1];
			var inputSpan:Number = inputEnd - inputStart;
			var cycleCount:Number;
			
			dt = dt % inputEnd;
						
			// Account for pre-infinity mode
			var outputOffset:Number = 0.0;
			
			if( dt <= inputStart )
			{
				switch( preInfinity )
				{
					case INFINITY_CONSTANT: return outputStart;
					case INFINITY_LINEAR: return outputStart + (dt - inputStart) * (values[1] - outputStart) / (keys[1] - inputStart);
					case INFINITY_CYCLE: { cycleCount = Math.ceil((inputStart - dt) / inputSpan); dt += cycleCount * inputSpan; break; }
					case INFINITY_CYCLE_RELATIVE: { cycleCount = Math.ceil((inputStart - dt) / inputSpan); dt += cycleCount * inputSpan; outputOffset -= cycleCount * (outputEnd - outputStart); break; }
					case INFINITY_OSCILLATE: { cycleCount = Math.ceil((inputStart - dt) / (2.0 * inputSpan)); dt += cycleCount * 2.0 * inputSpan; dt = inputEnd - Math.abs(dt - inputEnd); break; }
					case INFINITY_UNKNOWN: default: return outputStart;
				}
			}
			else if (dt >= inputEnd)
			{
				// Account for post-infinity mode
				switch (postInfinity)
				{
					case INFINITY_CONSTANT: return outputEnd;
					case INFINITY_LINEAR: return outputEnd + (dt - inputEnd) * (values[keys.length - 2] - outputEnd) / (keys[keys.length - 2] - inputEnd);
					case INFINITY_CYCLE: { cycleCount = Math.ceil((dt - inputEnd) / inputSpan); dt -= cycleCount * inputSpan; break; }
					case INFINITY_CYCLE_RELATIVE: { cycleCount = Math.ceil((dt - inputEnd) / inputSpan); dt -= cycleCount * inputSpan; outputOffset += cycleCount * (outputEnd - outputStart); break; }
					case INFINITY_OSCILLATE: { cycleCount = Math.ceil((dt - inputEnd) / (2.0 * inputSpan)); dt -= cycleCount * 2.0 * inputSpan; dt = inputStart + Math.abs(dt - inputStart); break; }
					case INFINITY_UNKNOWN: default: return outputEnd;
				}
			}
			
			// speed up interval search
			var approxi:int = Math.ceil((dt/inputEnd) * this.keys.length);
			
			// Find the current interval
			for( i = approxi; i < this.keys.length; ++i )
				if( this.keys[i] > dt ) break;
			var index:int = i;
			
			// Get the keys and values for this interval
			var endKey:Number = this.keys[index];
			var startKey:Number = this.keys[index - 1];
			var endValue:Number = this.values[index];
			var startValue:Number = this.values[index - 1];
			var output:Number;
			
			switch( interpolationType )
			{
				case INTERPOLATION_LINEAR:
					output = (dt - startKey) / (endKey - startKey) * (endValue - startValue) + startValue;
					break;
					
				case INTERPOLATION_STEP:
				default:
					output = startValue;
					break;
			}

			return outputOffset + output;
		}
		
		/**
		 * 
		 * @param	dt	frame time in milliseconds.
		 * 
		 * @return
		 */
		public function update( dt:Number ):void
		{
		}
	}	
}
