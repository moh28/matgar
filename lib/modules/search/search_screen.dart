import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/search_cubit/search_cubit.dart';
import '../../shared/cubit/search_cubit/search_states.dart';
import '../../shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'MA^!^GR',
                style: TextStyle(color: defaultColor),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: defaultColor,
                ),
              ),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormFeild(
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (String?value){
                          if (value!.isEmpty) {
                            return 'Enter Text To Search';
                          } else {
                            return null;
                          }
                        },
                        onSubmit: (String? text){
                          SearchCubit.get(context).search(text!);
                        },
                        label: 'SEARCH',
                        prefix: Icons.search),
                    const SizedBox(height: 10.0,),
                    if(state is SearchLoadingState)
                     const LinearProgressIndicator(color: defaultColor,),
                    const SizedBox(height: 10.0,),
                    if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildListProduct(SearchCubit.get(context).model!.data!.data[index],context,isOldPrice: false),
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: SearchCubit.get(context).model!.data!.data.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
