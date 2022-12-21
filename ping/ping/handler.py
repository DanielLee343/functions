import random
import time

def handle(req):
    quotes = [
        'Neo: We need guns. Lots of guns.',
        'Switch: Great, the digital pimp at work.',
        'Trinity: Dodge this.',
        "Neo: I don't like the idea that I'm not in control of my life.",
        'Neo: There is no spoon!',
        'Cypher: Ignorance is bliss.'
    ]
    
    time.sleep(random.randint(10,30))
    
    return random.choice(quotes)