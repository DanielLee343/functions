import json

# str = '{"n": "19000"}'
# payload = json.loads(str)
# if 'n' in payload:
#     times = int(payload['n'])
#     print("n is: ", times)
# else:
#     print("no such n")

x = """{
    "Name": "Jennifer Smith",
    "Contact Number": 7867567898,
    "Email": "jen123@gmail.com",
    "Hobbies":["Reading", "Sketching", "Horse Riding"]
    }"""
  
# parse x:
y = json.loads(x)
print(type(y))
