#include <stdio.h>
#include <strings.h>

#include <erl_nif.h>

#include <boost/math/special_functions.hpp>

#define MAXBUFLEN 1024

static ERL_NIF_TERM _gamma_p(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    double a;
    double z;
    long double res;
    
    enif_get_double(env, argv[0], &a);
    enif_get_double(env, argv[1], &z);

    res = boost::math::gamma_p((long double)a, (long double)z);
    
    return enif_make_double(env, res);
}

static ErlNifFunc nif_funcs[] =
{
  {"_gamma_p", 2, _gamma_p}
};
ERL_NIF_INIT(Elixir.Exboost.Math,nif_funcs,NULL,NULL,NULL,NULL)
