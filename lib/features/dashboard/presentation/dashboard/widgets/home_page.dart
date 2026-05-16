import 'package:ecommerce_app/core/navigation/goto.dart';
import 'package:ecommerce_app/core/navigation/routes.dart';
import 'package:ecommerce_app/features/dashboard/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(GetCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      body: SafeArea(
        child: BlocConsumer<DashboardBloc, DashboardState>(
          listener: (context, state) {
            if (state is DashboardLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) {
                  return const Center(child: CircularProgressIndicator());
                },
              );
            }

            if (state is DashboardError) {
              Navigator.pop(context);

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text(state.message)));
            }

            if (state is DashboardLoaded) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is DashboardLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TOP HEADER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Hello", style: TextStyle(color: Colors.grey, fontSize: 16)),
                            SizedBox(height: 4),
                            Text("Welcome Back", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                          ],
                        ),

                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.notifications_none_rounded, size: 28),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    /// BANNER
                    Container(
                      height: 200,
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          colors: [Color(0xff1F1C2C), Color(0xff928DAB)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Shop Smart", style: TextStyle(color: Colors.white70, fontSize: 18)),

                          const SizedBox(height: 10),

                          const Text(
                            "Discover\nPremium Products",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),

                          const SizedBox(height: 18),

                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Text("Explore Now", style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    /// SEARCH BAR
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search products...",
                          icon: Icon(Icons.search),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// CATEGORY TITLE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Categories", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

                        Text(
                          "See All",
                          style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// GRID VIEW
                    GridView.builder(
                      itemCount: state.categories.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 18,
                        mainAxisSpacing: 18,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        final category = state.categories[index];

                        /// DIFFERENT COLORS
                        final List<List<Color>> gradients = [
                          [const Color(0xffFF9A9E), const Color(0xffFAD0C4)],
                          [const Color(0xffA18CD1), const Color(0xffFBC2EB)],
                          [const Color(0xffF6D365), const Color(0xffFDA085)],
                          [const Color(0xff84FAB0), const Color(0xff8FD3F4)],
                          [const Color(0xffFCCB90), const Color(0xffD57EEB)],
                          [const Color(0xff30CFD0), const Color(0xff330867)],
                        ];

                        /// DIFFERENT ICONS
                        final List<IconData> icons = [
                          Icons.checkroom,
                          Icons.phone_iphone,
                          Icons.laptop_mac,
                          Icons.watch,
                          Icons.sports_esports,
                          Icons.shopping_bag,
                        ];

                        final gradient = gradients[index % gradients.length];
                        final icon = icons[index % icons.length];

                        return InkWell(
                          onTap: () {
                            context.pushNamed(Routes.products, arguments: state.categories[index]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              gradient: LinearGradient(
                                colors: gradient,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: gradient.first.withOpacity(0.35),
                                  blurRadius: 16,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                /// BIG BACKGROUND ICON
                                Positioned(
                                  right: -10,
                                  bottom: -10,
                                  child: Icon(icon, size: 90, color: Colors.white.withOpacity(0.15)),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(18),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: Icon(icon, color: Colors.white, size: 30),
                                      ),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            category.name.toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                          const SizedBox(height: 6),

                                          const Text(
                                            "Explore Collection",
                                            style: TextStyle(color: Colors.white70, fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              );
            }

            if (state is DashboardError) {
              return Center(
                child: Text(state.message, style: const TextStyle(color: Colors.red, fontSize: 16)),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
