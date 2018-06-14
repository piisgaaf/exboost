/*
Copyright [2018] Pieter Rijken

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

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
