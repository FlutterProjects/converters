import "package:flutter/material.dart";
import "./category.dart";

void main()
{
	List<String> items = ["Length", "Mass", "Time"];	

	runApp
	(
		MaterialApp
		(						
			debugShowCheckedModeBanner: false,
			home: Scaffold
			(
				appBar: AppBar(title: Text("Converters")),
				body: ListView.builder
				(
					itemCount: items.length,
					itemBuilder: (BuildContext context, int index)
					{
						return Category(items[index]);
					}
				)
			),
		)		
	);
}