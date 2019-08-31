/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.0.4"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* Copy the first part of user declarations.  */
#line 1 "1605109.y" /* yacc.c:339  */

	#include <bits/stdc++.h>
	#include "SymbolTable.h"
	using namespace std;

	int yyparse();
	int yylex();
	void yyerror(char *msg);
	
	extern int yylineno;
	extern FILE* yyin;
	
	ofstream f_err("error.txt");
	ofstream f_out("code.asm");
	
	SymbolTable st;
	
	static int labels = 0;
	static int tempos = 0;
	vector<string> variables;
	vector< pair<string, int> > arrays;
	
	string newTemp(string id="", bool array = false, int arraysize = 0) {
		string ret = "";
		ret += id + "_" + to_string(tempos);
		++tempos;
		
		if(id == "") {
			ret = "T_" + ret;
			variables.push_back(ret);
		}
		else if(array) {
			ret = "A_" + ret;
			arrays.push_back(make_pair(ret, arraysize));
		}
		else {
			ret = "V_" + ret;
			variables.push_back(ret);
		}
			
		return ret;
	}
	
	string newLabel() {
		string ret = "LABEL_" + to_string(labels);
		++labels;
		return ret;
	}

#line 116 "1605109.tab.c" /* yacc.c:339  */

# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* In a future release of Bison, this section will be replaced
   by #include "1605109.tab.h".  */
#ifndef YY_YY_1605109_TAB_H_INCLUDED
# define YY_YY_1605109_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    PRINTLN = 258,
    IF = 259,
    FOR = 260,
    DO = 261,
    INT = 262,
    FLOAT = 263,
    VOID = 264,
    SWITCH = 265,
    DEFAULT = 266,
    WHILE = 267,
    BREAK = 268,
    CHAR = 269,
    DOUBLE = 270,
    RETURN = 271,
    CASE = 272,
    CONTINUE = 273,
    LOWER_THAN_ELSE = 274,
    ELSE = 275,
    CONST_INT = 276,
    CONST_FLOAT = 277,
    CONST_CHAR = 278,
    ADDOP = 279,
    MULOP = 280,
    INCOP = 281,
    DECOP = 282,
    RELOP = 283,
    ASSIGNOP = 284,
    LOGICOP = 285,
    BITOP = 286,
    NOT = 287,
    LPAREN = 288,
    RPAREN = 289,
    LCURL = 290,
    RCURL = 291,
    LTHIRD = 292,
    RTHIRD = 293,
    COMMA = 294,
    SEMICOLON = 295,
    ID = 296
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 51 "1605109.y" /* yacc.c:355  */

	SymbolInfo* info;

#line 202 "1605109.tab.c" /* yacc.c:355  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_1605109_TAB_H_INCLUDED  */

/* Copy the second part of user declarations.  */

#line 219 "1605109.tab.c" /* yacc.c:358  */

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE
# if (defined __GNUC__                                               \
      && (2 < __GNUC__ || (__GNUC__ == 2 && 96 <= __GNUC_MINOR__)))  \
     || defined __SUNPRO_C && 0x5110 <= __SUNPRO_C
#  define YY_ATTRIBUTE(Spec) __attribute__(Spec)
# else
#  define YY_ATTRIBUTE(Spec) /* empty */
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# define YY_ATTRIBUTE_PURE   YY_ATTRIBUTE ((__pure__))
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# define YY_ATTRIBUTE_UNUSED YY_ATTRIBUTE ((__unused__))
#endif

#if !defined _Noreturn \
     && (!defined __STDC_VERSION__ || __STDC_VERSION__ < 201112)
# if defined _MSC_VER && 1200 <= _MSC_VER
#  define _Noreturn __declspec (noreturn)
# else
#  define _Noreturn YY_ATTRIBUTE ((__noreturn__))
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN \
    _Pragma ("GCC diagnostic push") \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")\
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif


#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYSIZE_T yynewbytes;                                            \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / sizeof (*yyptr);                          \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  11
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   147

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  42
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  25
/* YYNRULES -- Number of rules.  */
#define YYNRULES  65
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  119

/* YYTRANSLATE[YYX] -- Symbol number corresponding to YYX as returned
   by yylex, with out-of-bounds checking.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   296

#define YYTRANSLATE(YYX)                                                \
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, without out-of-bounds checking.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,    73,    73,    96,   103,   111,   116,   121,   129,   137,
     144,   149,   158,   161,   164,   167,   174,   174,   181,   189,
     197,   202,   207,   215,   224,   234,   243,   256,   261,   272,
     277,   282,   287,   308,   324,   346,   365,   368,   374,   379,
     387,   394,   416,   421,   439,   444,   480,   485,   530,   535,
     556,   561,   591,   601,   609,   617,   629,   634,   639,   644,
     649,   664,   683,   686,   693,   696
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "PRINTLN", "IF", "FOR", "DO", "INT",
  "FLOAT", "VOID", "SWITCH", "DEFAULT", "WHILE", "BREAK", "CHAR", "DOUBLE",
  "RETURN", "CASE", "CONTINUE", "LOWER_THAN_ELSE", "ELSE", "CONST_INT",
  "CONST_FLOAT", "CONST_CHAR", "ADDOP", "MULOP", "INCOP", "DECOP", "RELOP",
  "ASSIGNOP", "LOGICOP", "BITOP", "NOT", "LPAREN", "RPAREN", "LCURL",
  "RCURL", "LTHIRD", "RTHIRD", "COMMA", "SEMICOLON", "ID", "$accept",
  "start", "program", "unit", "func_declaration", "func_definition",
  "parameter_list", "compound_statement", "$@1", "var_declaration",
  "type_specifier", "declaration_list", "statements", "statement",
  "expression_statement", "variable", "expression", "logic_expression",
  "rel_expression", "simple_expression", "term", "unary_expression",
  "factor", "argument_list", "arguments", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296
};
# endif

#define YYPACT_NINF -71

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-71)))

#define YYTABLE_NINF -1

#define yytable_value_is_error(Yytable_value) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int8 yypact[] =
{
      70,   -71,   -71,   -71,     3,    70,   -71,   -71,   -71,   -71,
      -8,   -71,   -71,    -2,    20,    17,    25,    13,   -71,   -22,
     -19,    30,    52,    55,    57,   -71,   -71,   -12,    70,   -71,
     -71,    73,   -71,    79,   -71,   -71,    63,    60,    69,    72,
      76,    77,   100,   -71,   -71,   100,   100,   100,   -71,    37,
     -71,   -71,    65,    40,   -71,   -71,   -10,    78,   -71,    83,
      61,    92,   -71,   -71,   -71,   -71,    82,   100,    75,   100,
      85,    42,   -71,   -71,    93,   100,   100,    89,   -71,   -71,
     -71,   -71,   100,   -71,   100,   100,   100,   100,    94,    95,
      75,    96,   -71,   -71,   -71,    97,    98,   101,   -71,   -71,
      92,   110,   -71,   102,    79,   100,    79,   -71,   100,   -71,
     -71,   115,   104,   -71,   -71,    79,    79,   -71,   -71
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,    20,    21,    22,     0,     2,     4,     6,     7,     5,
       0,     1,     3,    25,     0,     0,     0,     0,    19,     0,
       0,    15,     0,    23,    16,     9,    11,     0,     0,    14,
      26,     0,    18,     0,     8,    10,    13,     0,     0,     0,
       0,     0,     0,    58,    59,     0,     0,     0,    38,    40,
      31,    29,     0,     0,    27,    30,    55,     0,    42,    44,
      46,    48,    50,    54,    12,    24,     0,     0,     0,     0,
       0,    55,    52,    53,     0,    63,     0,    25,    17,    28,
      60,    61,     0,    39,     0,     0,     0,     0,     0,     0,
       0,     0,    37,    57,    65,     0,    62,     0,    43,    45,
      49,    47,    51,     0,     0,     0,     0,    56,     0,    41,
      36,    33,     0,    35,    64,     0,     0,    34,    32
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
     -71,   -71,   -71,   131,   -71,   -71,   -71,    -5,   -71,    53,
       6,   -71,   -71,   -49,   -58,   -45,   -40,   -70,    56,    58,
      62,   -37,   -71,   -71,   -71
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     4,     5,     6,     7,     8,    20,    50,    33,    51,
      52,    14,    53,    54,    55,    56,    57,    58,    59,    60,
      61,    62,    63,    95,    96
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_uint8 yytable[] =
{
      71,    71,    70,    11,    79,    94,    10,    74,    72,    73,
      90,    10,    98,    24,    26,    27,    80,    81,    25,    82,
      28,    21,    35,    24,     1,     2,     3,    89,    34,    91,
      71,    15,   105,    13,    36,    16,    97,    71,   114,    71,
      71,    71,    71,    38,    39,    40,    22,     1,     2,     3,
     102,    19,    41,     9,    23,   111,    42,   113,     9,    17,
      18,    43,    44,    71,    45,   112,   117,   118,    80,    81,
      75,    29,    46,    47,    76,    24,    78,     1,     2,     3,
      48,    49,    38,    39,    40,    85,     1,     2,     3,    86,
      30,    41,    31,    32,    37,    42,    43,    44,    65,    45,
      43,    44,    66,    45,    64,    67,    77,    46,    47,    68,
      69,    46,    47,    84,    24,    48,    49,    87,    83,    48,
      49,    43,    44,    88,    45,    92,    16,    93,   103,   104,
     106,   107,    46,    47,    85,   115,    12,   108,   116,   109,
      99,    49,   110,     0,   101,     0,     0,   100
};

static const yytype_int8 yycheck[] =
{
      45,    46,    42,     0,    53,    75,     0,    47,    45,    46,
      68,     5,    82,    35,    19,    34,    26,    27,    40,    29,
      39,    15,    27,    35,     7,     8,     9,    67,    40,    69,
      75,    33,    90,    41,    28,    37,    76,    82,   108,    84,
      85,    86,    87,     3,     4,     5,    21,     7,     8,     9,
      87,    34,    12,     0,    41,   104,    16,   106,     5,    39,
      40,    21,    22,   108,    24,   105,   115,   116,    26,    27,
      33,    41,    32,    33,    37,    35,    36,     7,     8,     9,
      40,    41,     3,     4,     5,    24,     7,     8,     9,    28,
      38,    12,    37,    36,    21,    16,    21,    22,    38,    24,
      21,    22,    33,    24,    41,    33,    41,    32,    33,    33,
      33,    32,    33,    30,    35,    40,    41,    25,    40,    40,
      41,    21,    22,    41,    24,    40,    37,    34,    34,    34,
      34,    34,    32,    33,    24,    20,     5,    39,    34,    38,
      84,    41,    40,    -1,    86,    -1,    -1,    85
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     7,     8,     9,    43,    44,    45,    46,    47,    51,
      52,     0,    45,    41,    53,    33,    37,    39,    40,    34,
      48,    52,    21,    41,    35,    40,    49,    34,    39,    41,
      38,    37,    36,    50,    40,    49,    52,    21,     3,     4,
       5,    12,    16,    21,    22,    24,    32,    33,    40,    41,
      49,    51,    52,    54,    55,    56,    57,    58,    59,    60,
      61,    62,    63,    64,    41,    38,    33,    33,    33,    33,
      58,    57,    63,    63,    58,    33,    37,    41,    36,    55,
      26,    27,    29,    40,    30,    24,    28,    25,    41,    58,
      56,    58,    40,    34,    59,    65,    66,    58,    59,    60,
      62,    61,    63,    34,    34,    56,    34,    34,    39,    38,
      40,    55,    58,    55,    59,    20,    34,    55,    55
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    42,    43,    44,    44,    45,    45,    45,    46,    46,
      47,    47,    48,    48,    48,    48,    50,    49,    49,    51,
      52,    52,    52,    53,    53,    53,    53,    54,    54,    55,
      55,    55,    55,    55,    55,    55,    55,    55,    56,    56,
      57,    57,    58,    58,    59,    59,    60,    60,    61,    61,
      62,    62,    63,    63,    63,    64,    64,    64,    64,    64,
      64,    64,    65,    65,    66,    66
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     2,     1,     1,     1,     1,     6,     5,
       6,     5,     4,     3,     2,     1,     0,     4,     2,     3,
       1,     1,     1,     3,     6,     1,     4,     1,     2,     1,
       1,     1,     7,     5,     7,     5,     5,     3,     1,     2,
       1,     4,     1,     3,     1,     3,     1,     3,     1,     3,
       1,     3,     2,     2,     1,     1,     4,     3,     1,     1,
       2,     2,     1,     0,     3,     1
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                  \
do                                                              \
  if (yychar == YYEMPTY)                                        \
    {                                                           \
      yychar = (Token);                                         \
      yylval = (Value);                                         \
      YYPOPSTACK (yylen);                                       \
      yystate = *yyssp;                                         \
      goto yybackup;                                            \
    }                                                           \
  else                                                          \
    {                                                           \
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;                                                  \
    }                                                           \
while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*----------------------------------------.
| Print this symbol's value on YYOUTPUT.  |
`----------------------------------------*/

static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
  YYUSE (yytype);
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyoutput, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  unsigned long int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[yyssp[yyi + 1 - yynrhs]],
                       &(yyvsp[(yyi + 1) - (yynrhs)])
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
yystrlen (const char *yystr)
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            /* Fall through.  */
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (! (yysize <= yysize1
                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                    return 2;
                  yysize = yysize1;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
      return 2;
    yysize = yysize1;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        YYSTYPE *yyvs1 = yyvs;
        yytype_int16 *yyss1 = yyss;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * sizeof (*yyssp),
                    &yyvs1, yysize * sizeof (*yyvsp),
                    &yystacksize);

        yyss = yyss1;
        yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yytype_int16 *yyss1 = yyss;
        union yyalloc *yyptr =
          (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
                  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 73 "1605109.y" /* yacc.c:1646  */
    {

		(yyval.info) = (yyvsp[0].info);
		
		f_out << ".MODEL SMALL\n";
		f_out << ".STACK 100H\n\n";
		f_out << ".DATA\n";
		for(auto &qq : arrays) f_out << qq.first << " DW " << qq.second << " DUP(?)\n";
		for(auto &qq : variables) f_out << qq << " DW ?\n";
		f_out << "\n.CODE\n";
		f_out << "MAIN PROC\n";
		f_out << "MOV AX, @DATA\n";
		f_out << "MOV DS, AX\n\n";
		f_out << (yyval.info)->code << "\n";
		f_out << "MOV AH, 4CH\n";
		f_out << "INT 21H\n";
		f_out << "MAIN ENDP\n";
		f_out << "END MAIN\n";

	}
#line 1404 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 3:
#line 96 "1605109.y" /* yacc.c:1646  */
    {

		(yyval.info) = (yyvsp[-1].info);
		(yyval.info)->code += (yyvsp[0].info)->code;
		delete (yyvsp[0].info);

	}
#line 1416 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 4:
#line 103 "1605109.y" /* yacc.c:1646  */
    {

		(yyval.info) = (yyvsp[0].info);

	}
#line 1426 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 5:
#line 111 "1605109.y" /* yacc.c:1646  */
    {

		(yyval.info) = (yyvsp[0].info);

	}
#line 1436 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 6:
#line 116 "1605109.y" /* yacc.c:1646  */
    {

		(yyval.info) = (yyvsp[0].info);

	}
#line 1446 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 7:
#line 121 "1605109.y" /* yacc.c:1646  */
    {

		(yyval.info) = (yyvsp[0].info);

	}
#line 1456 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 8:
#line 129 "1605109.y" /* yacc.c:1646  */
    {
		// Oh, I want you, I want you, I want you
		// On a chair with a dead magazine
		// In the cave at the tip of the lilly
		// In some hallway where love's never been
		// On a bed where the moon has been sweating
		// In a cry filled with footsteps and sand
	}
#line 1469 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 9:
#line 137 "1605109.y" /* yacc.c:1646  */
    {
		// Aey, aey, aey, aey
	}
#line 1477 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 10:
#line 144 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = (yyvsp[0].info);
		
	}
#line 1487 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 11:
#line 149 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = (yyvsp[0].info);
		
	}
#line 1497 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 12:
#line 158 "1605109.y" /* yacc.c:1646  */
    {
		
	}
#line 1505 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 13:
#line 161 "1605109.y" /* yacc.c:1646  */
    {
		
	}
#line 1513 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 14:
#line 164 "1605109.y" /* yacc.c:1646  */
    {
		
	}
#line 1521 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 15:
#line 167 "1605109.y" /* yacc.c:1646  */
    {
		
	}
#line 1529 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 16:
#line 174 "1605109.y" /* yacc.c:1646  */
    { st.add_scope(); }
#line 1535 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 17:
#line 174 "1605109.y" /* yacc.c:1646  */
    {

		(yyval.info) = (yyvsp[-1].info);
		
		st.remove_scope();
		
	}
#line 1547 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 18:
#line 181 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = (yyvsp[-1].info);
		
	}
#line 1557 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 19:
#line 189 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = (yyvsp[-2].info);
		
	}
#line 1567 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 20:
#line 197 "1605109.y" /* yacc.c:1646  */
    {
	
		(yyval.info) = (yyvsp[0].info);
		
	}
#line 1577 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 21:
#line 202 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = (yyvsp[0].info);
		
	}
#line 1587 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 22:
#line 207 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = (yyvsp[0].info);
		
	}
#line 1597 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 23:
#line 215 "1605109.y" /* yacc.c:1646  */
    {
		
		string id = (yyvsp[0].info)->symbol;
		(yyvsp[0].info)->symbol = newTemp(id);
		st.insert(id, (yyvsp[0].info));
		
		(yyval.info) = new SymbolInfo();
		
	}
#line 1611 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 24:
#line 224 "1605109.y" /* yacc.c:1646  */
    {
		
		string id = (yyvsp[-3].info)->symbol;
		(yyvsp[-3].info)->symbol = newTemp(id, true, stoi((yyvsp[-1].info)->symbol));
		(yyvsp[-3].info)->type = "array";
		st.insert(id, (yyvsp[-3].info));
		
		(yyval.info) = new SymbolInfo();
		
	}
#line 1626 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 25:
#line 234 "1605109.y" /* yacc.c:1646  */
    {
		
		string id = (yyvsp[0].info)->symbol;
		(yyvsp[0].info)->symbol = newTemp(id);
		st.insert(id, (yyvsp[0].info));
		
		(yyval.info) = new SymbolInfo();
		
	}
#line 1640 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 26:
#line 243 "1605109.y" /* yacc.c:1646  */
    {
		
		string id = (yyvsp[-3].info)->symbol;
		(yyvsp[-3].info)->symbol = newTemp(id, true, stoi((yyvsp[-1].info)->symbol));
		(yyvsp[-3].info)->type = "array";
		st.insert(id, (yyvsp[-3].info));
		
		(yyval.info) = new SymbolInfo();
		
	}
#line 1655 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 27:
#line 256 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = (yyvsp[0].info);
		
	}
#line 1665 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 28:
#line 261 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = (yyvsp[-1].info);
		(yyval.info)->code += (yyvsp[0].info)->code;
		
		delete (yyvsp[0].info);
		
	}
#line 1678 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 29:
#line 272 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = (yyvsp[0].info);
		
	}
#line 1688 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 30:
#line 277 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = (yyvsp[0].info);
		
	}
#line 1698 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 31:
#line 282 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = (yyvsp[0].info);
		
	}
#line 1708 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 32:
#line 287 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = new SymbolInfo();
		
		string startLabel = newLabel();
		string endLabel = newLabel();
		
		(yyval.info)->code = (yyvsp[-4].info)->code;
		(yyval.info)->code += startLabel + ":\n";
		(yyval.info)->code += (yyvsp[-3].info)->code;
		(yyval.info)->code += "MOV AX, " + (yyvsp[-3].info)->symbol + "\n";
		(yyval.info)->code += "CMP AX, 0\n";
		(yyval.info)->code += "JE " + endLabel + "\n";
		(yyval.info)->code += (yyvsp[0].info)->code;
		(yyval.info)->code += (yyvsp[-2].info)->code;
		(yyval.info)->code += "JMP " + startLabel + "\n";
		(yyval.info)->code += endLabel + ":\n";
		
		(yyval.info)->symbol = "for";
		
	}
#line 1734 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 33:
#line 308 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = (yyvsp[-2].info);
		
		string label = newLabel();
		(yyval.info)->code += "MOV AX, " + (yyvsp[-2].info)->symbol + "\n";
		(yyval.info)->code += "CMP AX, 0\n";
		(yyval.info)->code += "JE " + label + "\n";
		(yyval.info)->code += (yyvsp[0].info)->code;
		(yyval.info)->code += label + ":\n";
		
		(yyval.info)->symbol = "if";
		
		delete (yyvsp[0].info);
		
	}
#line 1755 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 34:
#line 324 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = (yyvsp[-4].info);
		
		string endLabel = newLabel();
		string elseLabel = newLabel();
		
		(yyval.info)->code += "MOV AX, " + (yyvsp[-4].info)->symbol + "\n";
		(yyval.info)->code += "CMP AX, 0\n";
		(yyval.info)->code += "JE " + elseLabel + "\n";
		(yyval.info)->code += (yyvsp[-2].info)->code;
		(yyval.info)->code += "JMP " + endLabel + "\n";
		(yyval.info)->code += elseLabel + ":\n";
		(yyval.info)->code += (yyvsp[0].info)->code;
		(yyval.info)->code += endLabel + ":\n";
		
		(yyval.info)->symbol = "if_else";
		
		delete (yyvsp[-2].info);
		delete (yyvsp[0].info);
		
	}
#line 1782 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 35:
#line 346 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = new SymbolInfo();
		
		string startLabel = newLabel();
		string endLabel = newLabel();
		
		(yyval.info)->code = startLabel + ":\n";
		(yyval.info)->code += (yyvsp[-2].info)->code;
		(yyval.info)->code += "MOV AX, " + (yyvsp[-2].info)->symbol + "\n";
		(yyval.info)->code += "CMP AX, 0\n";
		(yyval.info)->code += "JE " + endLabel + "\n";
		(yyval.info)->code += (yyvsp[0].info)->code;
		(yyval.info)->code += "JMP " + startLabel + "\n";
		(yyval.info)->code += endLabel + ":\n";
		
		(yyval.info)->symbol = "while";
		
	}
#line 1806 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 36:
#line 365 "1605109.y" /* yacc.c:1646  */
    {
		
	}
#line 1814 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 37:
#line 368 "1605109.y" /* yacc.c:1646  */
    {
		
	}
#line 1822 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 38:
#line 374 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = (yyvsp[0].info);
		
	}
#line 1832 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 39:
#line 379 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = (yyvsp[-1].info);
		
	}
#line 1842 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 40:
#line 387 "1605109.y" /* yacc.c:1646  */
    {
		
		SymbolInfo *ptr = st.search((yyvsp[0].info)->symbol);
		assert(ptr != nullptr);
		(yyval.info) = new SymbolInfo(ptr);
		
	}
#line 1854 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 41:
#line 394 "1605109.y" /* yacc.c:1646  */
    {
		
		SymbolInfo *ptr = st.search((yyvsp[-3].info)->symbol);
		assert(ptr != nullptr);
		(yyval.info) = new SymbolInfo(ptr);
		// cerr << "Symbol wtf: " << ptr->symbol << "\n";
		
		(yyval.info)->type = "array";
		(yyval.info)->code += (yyvsp[-1].info)->code;
		(yyval.info)->code += "MOV BX, " + (yyvsp[-1].info)->symbol + "\n";
		(yyval.info)->code += "ADD BX, BX\n";
		
		// cerr << "variable codes:\n";
		// cerr << $3->code << "--------\n";
		// cerr << $$->code << "\n";
		// cerr << "-------end var\n";
		
		delete (yyvsp[-1].info);
	}
#line 1878 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 42:
#line 416 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = (yyvsp[0].info);
		
	}
#line 1888 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 43:
#line 421 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = (yyvsp[-2].info);
		(yyval.info)->code = (yyvsp[0].info)->code + (yyvsp[-2].info)->code;
		(yyval.info)->code += "MOV AX, " + (yyvsp[0].info)->symbol + "\n";
		
		if((yyval.info)->type == "array") {
			(yyval.info)->code += "MOV " + (yyval.info)->symbol + "[BX], AX\n";
		}
		else {
			(yyval.info)->code += "MOV " + (yyval.info)->symbol + ", AX\n";
		}
		
		delete (yyvsp[0].info);
	}
#line 1908 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 44:
#line 439 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = (yyvsp[0].info);
				
	}
#line 1918 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 45:
#line 444 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = new SymbolInfo();
		(yyval.info)->symbol = newTemp();
		
		string set1Label = newLabel();
		string set0Label = newLabel();
		string endLabel = newLabel();
		
		(yyval.info)->code = (yyvsp[-2].info)->code + (yyvsp[0].info)->code;
		if((yyvsp[-1].info)->symbol == "&&") {
			(yyval.info)->code += "MOV AX, " + (yyvsp[-2].info)->symbol + "\n";
			(yyval.info)->code += "ADD AX, " + (yyvsp[0].info)->symbol	+ "\n";
			(yyval.info)->code += "CMP AX, 2\n";
			(yyval.info)->code += "JNE " + set0Label + "\n";
		}
		else {
			(yyval.info)->code += "MOV AX, " + (yyvsp[-2].info)->symbol + "\n";
			(yyval.info)->code += "ADD AX, " + (yyvsp[0].info)->symbol + "\n";
			(yyval.info)->code += "CMP AX, 1\n";
			(yyval.info)->code += "JNE " + set0Label + "\n";
		}
		(yyval.info)->code += set1Label + ":\n";
		(yyval.info)->code += "MOV " + (yyval.info)->symbol + ", 1\n";
		(yyval.info)->code += "JMP " + endLabel + "\n";
		(yyval.info)->code += set0Label + ":\n";
		(yyval.info)->code += "MOV " + (yyval.info)->symbol + ", 0\n";
		(yyval.info)->code += endLabel + ":\n";
		
		delete (yyvsp[-2].info);
		delete (yyvsp[0].info);
		
	}
#line 1956 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 46:
#line 480 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = (yyvsp[0].info);
		
	}
#line 1966 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 47:
#line 485 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = new SymbolInfo();
		(yyval.info)->symbol = newTemp();
		
		string set1Label = newLabel();
		string set0Label = newLabel();
		string endLabel = newLabel();
		
		(yyval.info)->code = (yyvsp[-2].info)->code + (yyvsp[0].info)->code;
		(yyval.info)->code += "MOV AX, " + (yyvsp[-2].info)->symbol + "\n";
		(yyval.info)->code += "CMP AX, " + (yyvsp[0].info)->symbol + "\n";
		
		if((yyvsp[-1].info)->symbol == "<") {
			(yyval.info)->code += "JL " + set1Label + "\n";
		}
		else if((yyvsp[-1].info)->symbol == "<=") {
			(yyval.info)->code += "JLE " + set1Label + "\n";
		}
		else if((yyvsp[-1].info)->symbol == ">") {
			(yyval.info)->code += "JG " + set1Label + "\n";
		}
		else if((yyvsp[-1].info)->symbol == ">=") {
			(yyval.info)->code += "JGE " + set1Label + "\n";
		}
		else if((yyvsp[-1].info)->symbol == "==") {
			(yyval.info)->code += "JE " + set1Label + "\n";
		}
		else {
			(yyval.info)->code += "JNE " + set1Label + "\n";
		}
		
		(yyval.info)->code += "MOV " + (yyval.info)->symbol + ", 0\n";
		(yyval.info)->code += "JMP " + endLabel + "\n";
		(yyval.info)->code += set1Label + ":\n";
		(yyval.info)->code += "MOV " + (yyval.info)->symbol + ", 1\n";
		(yyval.info)->code += endLabel + ":\n";
		
		delete (yyvsp[-2].info);
		delete (yyvsp[0].info);
		
	}
#line 2013 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 48:
#line 530 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = (yyvsp[0].info);
		
	}
#line 2023 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 49:
#line 535 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = new SymbolInfo((yyvsp[-2].info));
		(yyval.info)->symbol = newTemp();
		(yyval.info)->code += (yyvsp[0].info)->code;
		(yyval.info)->code += "MOV AX, " + (yyvsp[-2].info)->symbol + "\n";
		
		if((yyvsp[-1].info)->symbol == "+") {
			(yyval.info)->code += "ADD AX, " + (yyvsp[0].info)->symbol + "\n";
		}
		else {
			(yyval.info)->code += "SUB AX, " + (yyvsp[0].info)->symbol + "\n";
		}
		
		(yyval.info)->code += "MOV " + (yyval.info)->symbol + ", AX\n";
		delete (yyvsp[0].info);
		
	}
#line 2046 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 50:
#line 556 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = (yyvsp[0].info);
		
	}
#line 2056 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 51:
#line 561 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = new SymbolInfo((yyvsp[-2].info));
		(yyval.info)->symbol = newTemp();
		
		(yyval.info)->code += (yyvsp[0].info)->code;
		(yyval.info)->code += "MOV AX, " + (yyvsp[-2].info)->symbol + "\n";
		(yyval.info)->code += "MOV BX, " + (yyvsp[0].info)->symbol + "\n";
		
		if((yyvsp[-1].info)->symbol == "*") {
			(yyval.info)->code += "MUL BX\n";
			(yyval.info)->code += "MOV " + (yyval.info)->symbol + ", AX\n";
		}
		else if((yyvsp[-1].info)->symbol == "/") {
			(yyval.info)->code += "MOV DX, 0\n";
			(yyval.info)->code += "DIV BX\n";
			(yyval.info)->code += "MOV " + (yyval.info)->symbol + ", AX\n";
		}
		else {
			(yyval.info)->code += "MOV DX, 0\n";
			(yyval.info)->code += "DIV BX\n";
			(yyval.info)->code += "MOV " + (yyval.info)->symbol + ", DX\n";
		}
		
		delete (yyvsp[0].info);
		
	}
#line 2088 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 52:
#line 591 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = (yyvsp[0].info);
		if((yyvsp[-1].info)->symbol == "-") {
			(yyval.info)->code += "MOV AX, 0\n";
			(yyval.info)->code += "SUB AX, " + (yyvsp[0].info)->symbol + "\n";
			(yyval.info)->code += "MOV " + (yyval.info)->symbol + ", AX\n";
		}
		
	}
#line 2103 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 53:
#line 601 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = (yyvsp[0].info);
		(yyval.info)->code += "MOV AX, " + (yyvsp[0].info)->symbol + "\n";
		(yyval.info)->code += "NOT AX\n";
		(yyval.info)->code += "MOV " + (yyval.info)->symbol + ", AX\n";
		
	}
#line 2116 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 54:
#line 609 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = (yyvsp[0].info);
		
	}
#line 2126 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 55:
#line 617 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = new SymbolInfo((yyvsp[0].info));
		
		if((yyval.info)->type == "array") {
			(yyval.info)->symbol = newTemp();
			(yyval.info)->code += "MOV AX, " + (yyvsp[0].info)->symbol + "[BX]\n";
			(yyval.info)->code += "MOV " + (yyval.info)->symbol + ", AX\n";
		}
		
	}
#line 2142 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 56:
#line 629 "1605109.y" /* yacc.c:1646  */
    {
		
		
		
	}
#line 2152 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 57:
#line 634 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = (yyvsp[-1].info);
		
	}
#line 2162 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 58:
#line 639 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = (yyvsp[0].info);
		
	}
#line 2172 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 59:
#line 644 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = (yyvsp[0].info);
		
	}
#line 2182 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 60:
#line 649 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = new SymbolInfo((yyvsp[-1].info));
		(yyval.info)->symbol = newTemp();
		
		if((yyvsp[-1].info)->type == "array") {
			(yyval.info)->code += "MOV AX, " + (yyvsp[-1].info)->symbol + "[BX]\n";
		}
		else {
			(yyval.info)->code += "MOV AX, " + (yyvsp[-1].info)->symbol + "\n";
		}
		(yyval.info)->code += "INC AX\n";
		(yyval.info)->code += "MOV " + (yyvsp[-1].info)->symbol + ", AX\n";
		
	}
#line 2202 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 61:
#line 664 "1605109.y" /* yacc.c:1646  */
    {
		
		(yyval.info) = new SymbolInfo((yyvsp[-1].info));
		(yyval.info)->symbol = newTemp();
		
		if((yyvsp[-1].info)->type == "array") {
			(yyval.info)->code += "MOV AX, " + (yyvsp[-1].info)->symbol + "[BX]\n";
		}
		else {
			(yyval.info)->code += "MOV AX, " + (yyvsp[-1].info)->symbol + "\n";
		}
		(yyval.info)->code += "DEC AX\n";
		(yyval.info)->code += "MOV " + (yyvsp[-1].info)->symbol + ", AX\n";
		
	}
#line 2222 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 62:
#line 683 "1605109.y" /* yacc.c:1646  */
    {
		
	}
#line 2230 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 63:
#line 686 "1605109.y" /* yacc.c:1646  */
    {
		
	}
#line 2238 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 64:
#line 693 "1605109.y" /* yacc.c:1646  */
    {
		
	}
#line 2246 "1605109.tab.c" /* yacc.c:1646  */
    break;

  case 65:
#line 696 "1605109.y" /* yacc.c:1646  */
    {
		
	}
#line 2254 "1605109.tab.c" /* yacc.c:1646  */
    break;


#line 2258 "1605109.tab.c" /* yacc.c:1646  */
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 701 "1605109.y" /* yacc.c:1906  */


int main(int argc, char **argv) {
	if(argc > 1) {
		if(!(yyin = fopen(argv[1], "r"))) {
			cerr << "Cannot open file \"" << argv[1] << "\"\n";
			return 1;
		}
	}
	
	yylineno = 1;
	yyparse();
	
	f_out.close();
	f_err.close();

	return 0;
}

void yyerror(char *s) {
	cerr << "Error: " << s << "\n";
}
