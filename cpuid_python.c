#define PY_SSIZE_T_CLEAN
#include <Python.h>
extern void cpuid(char *, uint32_t *, uint32_t *);

static PyObject *get_cpuid(PyObject *self, PyObject *args) {
    const char *name;
    char cpuinfo[16];
    uint32_t normal_features[2];
    uint32_t advanced_features[3];
    cpuid(cpuinfo, normal_features, advanced_features);
    PyObject *retval = Py_BuildValue("s (II) (III)", cpuinfo,
                                                     normal_features[0],
                                                     normal_features[1],
                                                     advanced_features[0],
                                                     advanced_features[1],
                                                     advanced_features[2]);

    return retval;
}

static PyMethodDef CPUIDMethods[] = {
    {"cpuid", get_cpuid, METH_VARARGS, "Returns a tuple containing the relevant CPU information."},
    {NULL, NULL, 0, NULL}
};

static struct PyModuleDef cpuid_module = {
    PyModuleDef_HEAD_INIT,
    "cpuid",
    "",
    -1,
    CPUIDMethods
};

PyMODINIT_FUNC PyInit_cpuid(void) {
    return PyModule_Create(&cpuid_module);
}

