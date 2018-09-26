README.txt


Project 4 - Build Me An Antfarm



Name:	   Halil Onur Arslantürk - Tolgahan Vahaplar

Email:     harslan1@binghamton.edu - tvahapl1@binghamton.edu



Program Explanation:



A ruby program that mainly benefits of 3 of the creational design patterns:
	


- Singleton

- Builder

- Factory



With the singleton method we instantiate only one meadow and all the hill creations and ant movements occur in this field. 


Queen ants benefit of builder pattern to create anthills and anthills are created with different strategies, which mainly affects their room creating strategies (Fireants are warrior species, weavers are builders, harvesters are natural foragers, each create more room parallel to their characteristic)

With factory pattern, typical ants are converted into warrior, forager and builders using object runtime modification.




Notes:



- The outputs are generated from the data in Anthill (count of each ant type), after each ant deletion, values appear as they should be. Contrary to this, in display additional dead ants are showing (But their hills don't since they are destroyed). Although it makes display a little bit odd, we wanted it to stay this way.
