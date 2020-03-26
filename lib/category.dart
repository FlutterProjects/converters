import "package:flutter/material.dart";
import 'package:udacity/converter.dart';

class Category extends StatelessWidget
{
	final String text;

	Category(this.text);

	Widget build(BuildContext context)
	{
		return 
		(			
			Material
			(				
				color: Colors.transparent,
				child: Directionality
				(
					child: Container
					(
						color: Colors.black12,
						margin: EdgeInsets.only(bottom: 5.0),
						height: 100,		
						child: InkWell
						(
							borderRadius: BorderRadius.all(Radius.circular(1.0)),
							highlightColor: Colors.red,
							splashColor: Colors.pink,
							onTap: () 
							{
								print(this.text);
								Navigator.push
								(
									context,
									MaterialPageRoute(builder: (context) => Converter(this.text, this.text.toLowerCase())),
								);
							},
							child: Row
							(					
								crossAxisAlignment: CrossAxisAlignment.stretch,			
								children: 
								[
									Padding(child: Icon(Icons.cake, size: 60.0), padding: EdgeInsets.all(10.0)),
									Center(child: Text(this.text, style: TextStyle(fontSize: 24.0),))
								],
							),
						),
					),
					textDirection: TextDirection.ltr,
				)
			)			
		);	
	}
}