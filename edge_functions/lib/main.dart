import 'package:counter_edge_functions/model/counter_response.dart';
import 'package:supabase_functions/supabase_functions.dart';
import 'package:edge_http_client/edge_http_client.dart';
import 'package:supabase/supabase.dart';

void main() {
  SupabaseFunctions(fetch: (request) async {
    final client = SupabaseClient(
      Deno.env.get('SUPABASE_URL')!,
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!,
      httpClient: EdgeHttpClient(),
    );

    if (request.method == 'POST') {
      await client.from('increments').insert({'amount': 1});
    }
    final count = await client.rpc('get_count').single() as int? ?? 0;
    final response = CounterResponse(count);
    return Response.json(response.toJson);
  });
}
