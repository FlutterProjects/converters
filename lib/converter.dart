import "package:flutter/material.dart";
import 'package:flutter/services.dart';

class Converter extends StatefulWidget 
{
	final String menuTitle;
	final String type;	
	
	final converters = 
	{
		"length": 
		{
			"units": ["Kilometer", "Meter", "Centimeter", "Inch", "Foot"],
			"conversions":
			[
				[0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
				[0.0, 1.0, 1000.0, 100000.0, 39370.0787, 3280.8399],
				[0.0, 0.001, 1.0, 100.0, 39.3700787, 3.2808399],
				[0.0, 0.00001, 0.01, 1.0, 0.393700787, 0.032808399],
				[0.0, 0.0000254, 0.0254, 2.54, 1.0, 0.0833333333],
				[0.0, 0.0003048, 0.3048, 30.48, 12.0, 1.0]
			]
		},
		"time":
		{
			"units": ["Minutes", "Seconds", "Hours"],
			"conversions": 
			[
				[0.0, 0.0, 0.0, 0.0],
				[0.0, 1.0, 60.0, 1/60],
				[0.0, 1/60, 1.0, 1/60/60],
				[0.0, 60.0, 3600.0, 1.0]
			]
		},
		"mass":
		{
			"units": ["Kilogram", "Gram"],
			"conversions": 
			[
				[0.0, 0.0, 0.0],
				[0.0, 1.0, 1000.0],
				[0.0, 1/1000, 1.0],				
			]
		}
	};

	final List<DropdownMenuItem<String>> unitsArray = [];

	Converter(this.menuTitle, this.type)
	{
		var units = this.converters[this.type]["units"];
		int counter = 1;		

		units.forEach((unit)
		{			
			var menuItem = DropdownMenuItem<String>
			(
				value: counter.toString(),
				child: Text(unit)
			);

			unitsArray.add(menuItem);
			counter++;
		});
	}

	createState() 
	{
		return ConverterState(this.menuTitle, this.unitsArray, this.converters[this.type]["conversions"].cast<List<double>>());
	}
}

class ConverterState extends State<Converter>
{
	final String menuTitle;
	final List<DropdownMenuItem<String>> unitsArray;	
	
	var currentValue1 = "1";
	var currentValue2 = "1";	

	var unit1 = TextEditingController();
	var unit2 = TextEditingController();

	ConverterState(this.menuTitle, this.unitsArray, this.conversions)
	{
		print(this.conversions);
	}

	List<List<double>> conversions;

	double unit1Tounit2;
	double unit2Tounit1;

	Widget build(BuildContext context)
	{		
		return MaterialApp
		(
			home: Scaffold
			(
				appBar: AppBar(title: Text(this.menuTitle + " Converter")),
				body: Container
				(					
					child: Column
					(
						children: 
						[					
							Align
							(
								alignment: Alignment.centerLeft,
								child: Container
								(								
									padding: EdgeInsets.only(left: 50.0, top: 30.0),								
									child: Text("From Unit", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold), textAlign: TextAlign.left)
								)
							),							
							Container
							(
								decoration: BoxDecoration
								(
									border: Border.all(color: Colors.red)
								),
								padding: EdgeInsets.only(left: 10.0),					
								margin: EdgeInsets.only(left: 50.0, right: 50.0, bottom: 20.0),
								child: DropdownButton<String>
								(									
									value: currentValue1,																
									isExpanded: true,
									items: this.unitsArray.toList(),
									onChanged: (String newValue) 
									{
										setState(() 
										{
											currentValue1 = newValue;

											unit1Tounit2 = this.conversions[int.parse(currentValue1)][int.parse(currentValue2)];
											unit2Tounit1 = this.conversions[int.parse(currentValue2)][int.parse(currentValue1)];

											unit1.text = unit2.text = "";
										});										
									},								
								),
							),	
							Align
							(
								alignment: Alignment.centerLeft,
								child: Container
								(								
									padding: EdgeInsets.only(left: 50.0),								
									child: Text("To Unit", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold), textAlign: TextAlign.left)
								)
							),					
							Container
							(
								decoration: BoxDecoration
								(
									border: Border.all(color: Colors.red)
								),								
								padding: EdgeInsets.only(left: 10.0),
								margin: EdgeInsets.only(left: 50.0, right: 50.0, bottom: 25.0),
								child: DropdownButton<String>
								(
									value: currentValue2,
									isExpanded: true,
									items: this.unitsArray.toList(),
									onChanged: (String newValue) 
									{
										setState(() 
										{
										  	currentValue2 = newValue;

										  	unit1Tounit2 = this.conversions[int.parse(currentValue1)][int.parse(currentValue2)];
											unit2Tounit1 = this.conversions[int.parse(currentValue2)][int.parse(currentValue1)];

											unit1.text = unit2.text = "";
										});
									},								
								),
							),
							Divider(color: Colors.black),							
							Container
							(
								decoration: BoxDecoration
								(
									border: Border.all(color: Colors.red)
								),
								padding: EdgeInsets.only(left: 10.0),
								margin: EdgeInsets.only(left: 50.0, right: 50.0, bottom: 10.0, top: 25.0),
								child: TextField
								(					
									controller: unit1,
									keyboardType: TextInputType.number,									
									style: TextStyle(fontSize: 25.0),									
									onChanged: (String newValue) 
									{
										setState(() 
										{
											if (unit1.text == "")
											{
												unit2.text = "";
											}
											else 
											{
												unit2.text = (double.parse(unit1.text.toString()) * unit1Tounit2).toString();
											}											
										});
									},
								)
							),							
							Container
							(
								decoration: BoxDecoration
								(
									border: Border.all(color: Colors.red)
								),
								padding: EdgeInsets.only(left: 10.0),
								margin: EdgeInsets.only(left: 50.0, right: 50.0),
								child: TextField
								(		
									controller: unit2,							
									keyboardType: TextInputType.number,									
									style: TextStyle(fontSize: 25.0),
									onChanged: (String newValue)
									{
										setState(() 
										{
											if (unit2.text == "")
											{
												unit1.text = "";
											}
											else 
											{
												unit1.text = (double.parse(unit2.text.toString()) * unit2Tounit1).toString();
											}
										});
									}
								)
							),

						]
					)
				)
			),
		);		
	}
}