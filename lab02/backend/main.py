from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()
app.add_middleware(
	CORSMiddleware,
	allow_origins=["*"],
	allow_credentials=True,
	allow_methods=["GET"],
	allow_headers=["*"],
)

@app.get("/")
def read_root():
    return {
	  "students": [
	    {
	      "name": "Mehrshad Lotfi",
	      "email": "mehrshad@optiop.org"
	    },
	    {
	      "name": "Reza Mohammadi",
	      "email": "reza@optiop.org"
	    }
	  ]
	}