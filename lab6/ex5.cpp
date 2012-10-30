# include <cstdio>
# include <iostream>
# include <vector>
# include <cctype>
# include <cstring>
# include <bitset>
using namespace std;
# define MAXC 256
/*
struct symbol
{
  char c;
  bool T;
  symbol() { c = '\0'; T = false; }
  symbol(char _c, bool _T) : c(_c), T(_T) {}
};
*/


void read_input();
void build_First(char);
void build_Follow();
void display();
void build_PPT();

struct Rule
{
  int S_id;
  int sz;
  int rhs[10];
  
};

Rule R[100];
int totalRules;

bitset<MAXC> First[MAXC];
bitset<MAXC> Follow[MAXC];
bool visited[MAXC];
bool valid[MAXC];
int M[MAXC][MAXC];

void read_input()
{
  int i,j;
  char ch,l[10], r[10];
  totalRules = 0;
  memset(valid, false, sizeof(valid));
  while(true)
    {
      scanf("%s %s", l, r);
      if(l[0] == '~')
	break;
     
      valid[ l[0] ] = true;
      R[totalRules].S_id = l[0];
      R[totalRules].sz = 0;
      for(i = 0; r[i]; i++)
	{
	  R[totalRules].rhs[ R[totalRules].sz++ ] = r[i];
	  valid[ (int)(r[i]) ] = true;
	  //cout << endl << (int)r[i];
	}
      totalRules++;
    }

  //cout << endl << valid[40];

  for(i = 0; i < MAXC; i++)
    {
      First[i].reset();
      Follow[i].reset();
    }

  memset(visited, false, sizeof(visited));
  for(i = 0; i < MAXC; i++)
    {
      if(!isupper((char)i))
	{
// terminal character bits are set to true
	  First[i].set(i);
	  Follow[i].set(i);
	  visited[i] = true;
	}
    }

 
  for(i = 0; i < totalRules; i++)
    {
      ch = R[i].S_id;
      if(R[i].rhs[0] == 'e')
	First[ch].set('e');
    }

  build_First('S');
  for(i = 'A'; i <= 'Z'; i++)
    if(!visited[i])
      build_First(i);
  build_Follow();
}


void build_First(char id)
{
  int i,j;
  char ch;
  visited[id] = true;

  for(i = 0; i < totalRules; i++)
    {
      if(R[i].S_id == id)
	{
	  for(j = 0; j < R[i].sz; j++)
	    {
	      ch = R[i].rhs[j];
	      if(!visited[ch])
		build_First(ch);
	      First[id] = First[id] | First[ch];
// checking for null production rules	      
	      if(!First[ch]['e'])
		break;

	    }

	}
    }
}

void build_Follow()
{
  int i,j,k;
  char ch;
  Follow['S'].set('$');
  for(i = 0; i < totalRules; i++)
    {
//parsing through each rule inside
      for(j = 0; j < R[i].sz - 1; j++)
	{
	  ch = R[i].rhs[j];
	  for(k = j + 1; k < R[i].sz; k++)
	    {
	      Follow[ch] = Follow[ch] | First[ R[i].rhs[k] ];
	      if(!First[R[i].rhs[k]]['e'])
		break;
	    }
	  
	}
    }

  for(i = 0; i < totalRules; i++)
    {
//parsing through rules for null production rules
      for(j = R[i].sz - 1; j >= 0; j--)
	{
	  ch = R[i].rhs[j];
	  if(isupper(ch))
	    Follow[ch] = Follow[ch] | Follow[ R[i].S_id ];
	  if(!First[ch]['e'])
	    break;
	}
  }
}


void build_PPT()
{
  int i,j;
  char ch;
  memset(M, -1, sizeof(M));
 for(i = 0; i < totalRules; i++)
    {
	  //cout<<"\nInside for";
	  ch = R[i].rhs[0];
//Terminal	  
	if(!isupper(ch) && ch!= 'e')
	    {
	      M[ R[i].S_id ][ch]=i;
	      //cout<<"\nblah blah...";
	      
	    }
	else if(!isupper(ch) && ch == 'e')
	  {
		for(j=0; j <MAXC;j++)
		  {
		   if((Follow[R[i].S_id][j]) && ((char)j != 'e' ))
		    { M[R[i].S_id][j] = i;
		      //cout<<"\nblah blah..."<<j;
		    }
		}
		
	  }
//Non - Terminal
	  else
	    {
		int flag = 0;
		for(j=0; j <MAXC;j++)
		{
		  if((First[ch][j]) && ((char)j != 'e' ))
		   { M[R[i].S_id][j] = i;
		   //cout<<"\nblah blah..."<<j;
		   }
		  else if((First[ch][j]) && ((char)j == 'e' ))
		    flag = 1;
		}
		if(flag)
		  for(j=0; j <MAXC;j++)
		  {
		   if((Follow[ch][j]) && ((char)j != 'e' ))
		    { M[R[i].S_id][j] = i;
		      //cout<<"\nblah blah..."<<j;
		    }
		}
	    }	  
    }
}
	    
int main()
{
  read_input();

  build_PPT();
  display();


  return 0;
}

void display()
{
  int i,j,k,m;
  char ch;
  cout << "First TABLE:\n";
  for(i = 'A'; i <= 'Z'; i++)
    {
      if(valid[i])
	{
	  cout << endl << (char)i << " --";
	  for(j = 0; j < MAXC; j++)
	    {
	      if(First[i][j])
		cout << (char)j << "    ";
	    }
	}
    }
  
  cout << endl << endl;;
  

 cout << "Follow TABLE:\n";
  for(i = 'A'; i <= 'Z'; i++)
    {
      Follow[i].reset('e');
      if(valid[i])
	{
	  cout << endl << (char)i << " --";
	  for(j = 0; j < MAXC; j++)
	    {
	      if(Follow[i][j])
		cout << (char)j << "    ";
	    }
	}
    }
  
  cout << endl << endl;

  cout << endl << "Predictive Parser Table: \n";
  cout << endl << "Non-terminal , Terminal --  Production Rule\n";
 // memset(M, -1, sizeof(M));
  for(i = 'A'; i <= 'Z'; i++)
    {
      for(j = 0; j < MAXC; j++)
	{
	  if(valid[i] && valid[j] && !isupper(j))
	    {
	      cout << endl << (char)i << ", " << (char)j << " --   "; 
	      k = M[i][j];
	      if(k == -1)
		{
		  cout<<"Error";
		}
	     else
		{
	      cout << (char)(R[k].S_id) << " ->  ";
	      for(m = 0; m < R[k].sz; m++)
		cout << (char)(R[k].rhs[m]);
	    	} 
	   }
	}
    }
  cout << endl << endl;
  cout << endl << valid['('];
}
	      
	      
